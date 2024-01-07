import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../exercise/model/exercise_list.dart';
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

  RoutineService({
    required this.routineDao,
    required this.exerciseDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
    required this.workoutDataDao,
    required this.templateDataDao,
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
          await exerciseGroupDao.add(exerciseGroup.copyWith(routineId: routineId));

      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        int exerciseSetId =
            await exerciseSetDao.add(exerciseSet.copyWith(exerciseGroupId: exerciseGroupId));

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao.add(exerciseSetData.copyWith(exerciseSetId: exerciseSetId));
        }
      }

      for (Note note in exerciseGroup.notes) {
        await noteDao.add(note.copyWith(exerciseGroupId: exerciseGroupId));
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

    await routineDao.modify(routine);

    for (int i = 0; i < exerciseList.getLength(); i++) {
      ExerciseGroupDto exerciseGroup = exerciseList.getExerciseGroup(i);
      await exerciseGroupDao.modify(exerciseGroup);

      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        await exerciseSetDao.modify(exerciseSet);

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao.modify(exerciseSetData);
        }
      }

      for (Note note in exerciseGroup.notes) {
        await noteDao.modify(note);
      }
    }

    return getTemplate(routine.id!);
  }

  void updateTemplateData(TemplateData data) {
    templateDataDao.modify(data);
  }

  void deleteTemplate(Template template) {
    routineDao.remove(template.routine);
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

  /// Removes a workout from the database.
  ///
  /// Throws [Exception] if the workout was not removed.
  Future<void> removeWorkout(Workout workout) async {
    int count = await routineDao.remove(workout.routine);

    if (count == 0) {
      throw Exception('Workout was not removed');
    }
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
