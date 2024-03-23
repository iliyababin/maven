import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../exercise/model/exercise_list.dart';
import '../../session/session.dart';
import '../../template/template.dart';
import '../../workout/workout.dart';

class RoutineService {
  final RoutineDao routineDao;
  final ExerciseDao exerciseDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;
  final WorkoutDataDao workoutDataDao;
  final TemplateDataDao templateDataDao;
  final SessionDataDao sessionDataDao;

  RoutineService({
    required this.routineDao,
    required this.exerciseDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
    required this.workoutDataDao,
    required this.templateDataDao,
    required this.sessionDataDao,
  });

  /// Gets a template from the database.
  ///
  /// Throws [Exception] if the provided ID does not exist.
  Future<Template> getTemplate(int templateDataId) async {
    TemplateData? templateData = await templateDataDao.get(templateDataId);

    if (templateData == null) {
      throw Exception('Template does not exist');
    }

    Routine routine = await getRoutine(templateData.routineId);
    List<ExerciseGroupDto> exerciseGroups = await _getExerciseGroups(routine.id!);

    return Template(
      routine: routine,
      data: templateData,
      exerciseList: ExerciseList(exerciseGroups),
      duration: getDuration(exerciseGroups),
      musclePercentages: await getMusclePercentages(exerciseGroups),
      volume: getVolume(exerciseGroups),
    );
  }

  /// Gets all templates from the database.
  Future<List<Template>> getTemplates() async {
    List<Template> templates = [];

    for (TemplateData templateData in await templateDataDao.getAll()) {
      templates.add(await getTemplate(templateData.id!));
    }

    return templates;
  }

  double getVolume(List<ExerciseGroupDto> exerciseGroups) {
    double pounds = 0;

    for (ExerciseGroupDto exerciseGroup in exerciseGroups) {
      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        double setPounds = 1;

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          if (exerciseSetData.fieldType == ExerciseFieldType.weight) {
            if (exerciseGroup.weightUnit == WeightUnit.pound) {
              setPounds *= exerciseSetData.valueAsDouble;
            } else if (exerciseGroup.weightUnit == WeightUnit.kilogram) {
              setPounds *= exerciseSetData.valueAsDouble * 2.20462262;
            }
          } else if (exerciseSetData.fieldType == ExerciseFieldType.reps) {
            setPounds *= exerciseSetData.valueAsDouble;
          }
        }
        pounds += setPounds;
      }
    }
    return pounds;
  }

  Future<Map<Muscle, double>> getMusclePercentages(List<ExerciseGroupDto> exerciseGroups) async {
    Map<Muscle, int> muscleCount = {};

    for (ExerciseGroupDto exerciseGroup in exerciseGroups) {
      Exercise? exercise = await exerciseDao.get(exerciseGroup.exerciseId);
      muscleCount[exercise!.muscle] = (muscleCount[exercise.muscle] ?? 0) + 1;
    }

    Map<Muscle, double> musclePercentages = {};
    for (Muscle muscle in muscleCount.keys) {
      musclePercentages[muscle] = muscleCount[muscle]! / exerciseGroups.length;
    }

    return musclePercentages;
  }

  Timed getDuration(List<ExerciseGroupDto> exerciseGroups) {
    Timed duration = const Timed.zero();

    for (ExerciseGroupDto exerciseGroup in exerciseGroups) {
      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        duration = duration.add(exerciseGroup.timer);
        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          if (exerciseSetData.fieldType == ExerciseFieldType.duration) {
            duration = duration.add(Timed.fromSeconds(exerciseSetData.valueAsDouble.toInt()));
          }
        }
      }
    }

    return duration;
  }

  /// Adds a template to the database.
  ///
  /// Throws [Exception] if the provided routine is not of type template.
  Future<Template> addTemplate(Routine routine, ExerciseList exerciseList) async {
    if (routine.type != RoutineType.template) {
      throw Exception('Routine must be of type template');
    }

    int routineId = await routineDao.add(routine);

    int templateDataId = await templateDataDao.add(TemplateData(
      routineId: routineId,
      sort: -1,
    ));

    for (int i = 0; i < exerciseList.getLength(); i++) {
      ExerciseGroupDto exerciseGroup = exerciseList.getExerciseGroup(i);
      int exerciseGroupId =
          await exerciseGroupDao.add(exerciseGroup.copyWith(id: null, routineId: routineId));

      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        int exerciseSetId = await exerciseSetDao
            .add(exerciseSet.copyWith(id: null, exerciseGroupId: exerciseGroupId));

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao
              .add(exerciseSetData.copyWith(id: null, exerciseSetId: exerciseSetId));
        }
      }

      for (Note note in exerciseGroup.notes) {
        await noteDao.add(note.copyWith(id: null, exerciseGroupId: exerciseGroupId));
      }
    }

    return getTemplate(templateDataId);
  }

  /// Updates a template in the database.
  ///
  /// Throws [Exception] if the provided routine is not of type template.
  Future<Template> updateTemplate(Routine routine, ExerciseList exerciseList) async {
    if (routine.type != RoutineType.template) {
      throw Exception('Routine must be of type template');
    }

    await routineDao.remove(routine);

    return addTemplate(routine, exerciseList);
  }

  void updateTemplateData(TemplateData data) {
    templateDataDao.modify(data);
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  /// Gets a routine from the database.
  ///
  /// Throws [Exception] if the provided ID does not exist.
  Future<Routine> getRoutine(int routineId) async {
    Routine? routine = await routineDao.get(routineId);

    if (routine == null) {
      throw Exception('Routine does not exist');
    }

    return routine;
  }

  /// Removes a routine from the database.
  ///
  /// Throws [Exception] if the workout was not removed.
  Future<void> deleteRoutine(Routine routine) async {
    int count = await routineDao.remove(routine);

    if (count == 0) {
      throw Exception('Workout was not removed');
    }
  }

  /// Gets a workout from the database.
  ///
  /// Returns null if there is no active workout.
  Future<Workout?> getWorkout() async {
    WorkoutData? workoutData = await workoutDataDao.getByIsActive();

    if (workoutData == null) {
      return null;
    }

    Routine routine = await getRoutine(workoutData.routineId);
    List<ExerciseGroupDto> exerciseGroups = await _getExerciseGroups(routine.id!);

    return Workout(
      routine: routine,
      data: workoutData,
      exerciseGroups: exerciseGroups,
    );
  }

  /// Adds a workout to the database.
  ///
  /// Throws [Exception] if the provided routine is not of type workout.
  Future<Workout> addWorkout(Routine routine) async {
    if (routine.type != RoutineType.workout) {
      throw Exception('Routine must be of type workout');
    }

    int routineId = await routineDao.add(routine);
    WorkoutData workoutData = WorkoutData(
      routineId: routineId,
      isActive: true,
      timeElapsed: const Timed.zero(),
    );
    int workoutDataId = await workoutDataDao.add(workoutData);

    return Workout(
      routine: routine.copyWith(id: routineId),
      data: workoutData.copyWith(id: workoutDataId),
      exerciseGroups: const [],
    );
  }

  /// Starts a workout from a template.
  Future<Workout?> startTemplate(Template template) async {
    Routine routine = Routine(
      name: template.routine.name,
      note: template.routine.note,
      timestamp: DateTime.now(),
      type: RoutineType.workout,
    );

    int routineId = await routineDao.add(routine);

    WorkoutData workoutData = WorkoutData(
      routineId: routineId,
      isActive: true,
      timeElapsed: const Timed.zero(),
    );

    int workoutDataId = await workoutDataDao.add(workoutData);

    List<ExerciseGroupDto> exerciseGroups = [];
    for (int i = 0; i < template.exerciseList.getLength(); i++) {
      ExerciseGroupDto exerciseGroup = template.exerciseList.getExerciseGroup(i);
      int exerciseGroupId =
          await exerciseGroupDao.add(exerciseGroup.copyWith(id: null, routineId: routineId));

      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        int exerciseSetId = await exerciseSetDao
            .add(exerciseSet.copyWith(id: null, exerciseGroupId: exerciseGroupId));

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao
              .add(exerciseSetData.copyWith(id: null, exerciseSetId: exerciseSetId));
        }
      }

      for (Note note in exerciseGroup.notes) {
        await noteDao.add(note.copyWith(exerciseGroupId: exerciseGroupId));
      }

      exerciseGroups.add(exerciseGroup.copyWith(id: exerciseGroupId));
    }

    return getWorkout();
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  /// Creates a session from a workout.
  ///
  /// Throws [Exception] if the workout does not exist.
  Future<Session> addSession(Workout workout) async {
    if (workout == null) {
      throw Exception('Workout does not exist');
    }

    int sessionId = await routineDao.add(workout.routine.copyWith(
      id: null,
      type: RoutineType.session,
      timestamp: DateTime.now(),
    ));

    int sessionDataId = await sessionDataDao.add(SessionData(
      timeElapsed: workout.data.timeElapsed,
      routineId: sessionId,
    ));

    for (ExerciseGroupDto exerciseGroup in workout.exerciseGroups) {
      ////////////////////////////////////////////////////////
      int completedSets = 0;
      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        int completedFields = 0;
        for (ExerciseSetDataDto data in exerciseSet.data) {
          if (data.value.isEmpty) continue;
          completedSets++;
        }
        if (completedFields == 0) continue;
      }
      if (completedSets == 0) continue;
      ////////////////////////////////////////////////////////

      int exerciseGroupId = await exerciseGroupDao.add(exerciseGroup.copyWith(
        id: null,
        routineId: sessionId,
      ));

      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        int exerciseSetId = await exerciseSetDao.add(exerciseSet.copyWith(
          id: null,
          exerciseGroupId: exerciseGroupId,
        ));

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao.add(exerciseSetData.copyWith(
            id: null,
            exerciseSetId: exerciseSetId,
          ));
        }
      }
    }

    return getSession(sessionDataId);
  }

  /// Adds sessions to the database accosiated with an import.
  Future<void> addSessions(List<Session> sessions, int importId) async {
    for (Session session in sessions) {
      int sessionId = await routineDao.add(session.routine);
      await sessionDataDao.add(SessionData(
        timeElapsed: session.data.timeElapsed,
        routineId: sessionId,
        importId: importId,
      ));

      for (ExerciseGroupDto group in session.exerciseGroups) {
        int exerciseGroupId = await exerciseGroupDao.add(group.copyWith(
          routineId: sessionId,
        ));

        for (ExerciseSetDto set in group.sets) {
          int exerciseSetId = await exerciseSetDao.add(set.copyWith(
            exerciseGroupId: exerciseGroupId,
          ));

          for (ExerciseSetDataDto data in set.data) {
            await exerciseSetDataDao.add(data.copyWith(
              exerciseSetId: exerciseSetId,
            ));
          }
        }
      }
    }
  }

  /// Gets a session from the database.
  ///
  /// Throws [Exception] if the provided ID does not exist.
  Future<Session> getSession(int sessionDataId) async {
    SessionData? sessionData = await sessionDataDao.get(sessionDataId);

    if (sessionData == null) {
      throw Exception('Session does not exist');
    }

    Routine routine = await getRoutine(sessionData.routineId);
    List<ExerciseGroupDto> exerciseGroups = await _getExerciseGroups(routine.id!);

    return Session(
      routine: routine,
      data: sessionData,
      exerciseGroups: exerciseGroups,
      musclePercentages: await getMusclePercentages(exerciseGroups),
      volume: getVolume(exerciseGroups),
    );
  }

  /// Gets all sessions from the database.
  Future<List<Session>> getSessions({SessionSort sort = SessionSort.newest}) async {
    List<Session> sessions = [];

    for (SessionData sessionData in await sessionDataDao.getAll()) {
      sessions.add(await getSession(sessionData.id!));
    }

    switch (sort) {
      case SessionSort.newest:
        sessions.sort((a, b) => a.routine.timestamp.compareTo(b.routine.timestamp));
        return sessions.reversed.toList();
      case SessionSort.oldest:
        sessions.sort((a, b) => a.routine.timestamp.compareTo(b.routine.timestamp));
      case SessionSort.volume:
        sessions.sort((a, b) {
          final propertyA = a.volume;
          final propertyB = b.volume;
          int result = propertyA.compareTo(propertyB);
          if (result < 0) {
            return 1;
          } else if (result > 0) {
            return -1;
          } else {
            return 0;
          }
        });
    }

    return sessions;
  }

  /// Helper methods
  Future<List<ExerciseGroupDto>> _getExerciseGroups(int routineId) async {
    List<ExerciseGroupDto> exerciseGroups = [];

    List<BaseExerciseGroup> baseExerciseGroups = await exerciseGroupDao.getByRoutineId(routineId);
    for (BaseExerciseGroup baseExerciseGroup in baseExerciseGroups) {
      List<Note> notes = await noteDao.getByExerciseGroupId(baseExerciseGroup.id!);
      List<ExerciseSetDto> exerciseSets = await _getExerciseSets(baseExerciseGroup);

      exerciseGroups.add(ExerciseGroupDto.fromBase(
        baseExerciseGroup: baseExerciseGroup,
        notes: notes,
        sets: exerciseSets,
      ));
    }

    return exerciseGroups;
  }

  Future<List<ExerciseSetDto>> _getExerciseSets(BaseExerciseGroup exerciseGroup) async {
    List<BaseExerciseSet> baseExerciseSets =
        await exerciseSetDao.getByExerciseGroupId(exerciseGroup.id!);
    List<ExerciseSetDto> exerciseSets = [];

    for (BaseExerciseSet baseExerciseSet in baseExerciseSets) {
      List<ExerciseSetDataDto> exerciseSetData = await _getExerciseSetData(baseExerciseSet);
      exerciseSets.add(ExerciseSetDto.fromBase(
        baseExerciseSet: baseExerciseSet,
        data: exerciseSetData,
      ));
    }

    return exerciseSets;
  }

  Future<List<ExerciseSetDataDto>> _getExerciseSetData(BaseExerciseSet exerciseSet) async {
    List<BaseExerciseSetData> baseExerciseSetDataList =
        await exerciseSetDataDao.getByExerciseSetId(exerciseSet.id!);
    return baseExerciseSetDataList
        .map((baseData) => ExerciseSetDataDto(
            id: baseData.id,
            value: baseData.value,
            fieldType: baseData.fieldType,
            exerciseSetId: baseData.exerciseSetId))
        .toList();
  }
}
