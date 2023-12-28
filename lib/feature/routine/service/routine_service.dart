import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../exercise/exercise.dart';
import '../../template/template.dart';
import '../../workout/workout.dart';

class RoutineService {
  final RoutineDao routineDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;
  final WorkoutDataDao workoutDataDao;

  RoutineService({
    required this.routineDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
    required this.workoutDataDao,
  });

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
    List<ExerciseGroup> exerciseGroups = await _getExerciseGroups(routine.id!);

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
      name: template.name,
      note: template.note,
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

    List<ExerciseGroup> exerciseGroups = [];
    for (ExerciseGroup exerciseGroup in template.exerciseGroups) {
      int exerciseGroupId =
          await exerciseGroupDao.add(exerciseGroup.copyWith(routineId: routineId));

      for (ExerciseSet exerciseSet in exerciseGroup.sets) {
        int exerciseSetId =
            await exerciseSetDao.add(exerciseSet.copyWith(exerciseGroupId: exerciseGroupId));

        for (ExerciseSetData exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao.add(exerciseSetData.copyWith(exerciseSetId: exerciseSetId));
        }
      }

      for (Note note in exerciseGroup.notes) {
        await noteDao.add(note.copyWith(exerciseGroupId: exerciseGroupId));
      }

      exerciseGroups.add(exerciseGroup.copyWith(id: exerciseGroupId));
    }

    return getWorkout();
  }

  Future<List<ExerciseGroup>> _getExerciseGroups(int routineId) async {
    List<ExerciseGroup> exerciseGroups = [];

    List<BaseExerciseGroup> baseExerciseGroups = await exerciseGroupDao.getByRoutineId(routineId);
    for (BaseExerciseGroup baseExerciseGroup in baseExerciseGroups) {
      List<Note> notes = await noteDao.getByExerciseGroupId(baseExerciseGroup.id!);
      List<ExerciseSet> exerciseSets = await _getExerciseSets(baseExerciseGroup);

      exerciseGroups.add(ExerciseGroup.fromBase(
        baseExerciseGroup: baseExerciseGroup,
        notes: notes,
        sets: exerciseSets,
      ));
    }

    return exerciseGroups;
  }

  Future<List<ExerciseSet>> _getExerciseSets(BaseExerciseGroup exerciseGroup) async {
    List<BaseExerciseSet> baseExerciseSets =
        await exerciseSetDao.getByExerciseGroupId(exerciseGroup.id!);
    List<ExerciseSet> exerciseSets = [];

    for (BaseExerciseSet baseExerciseSet in baseExerciseSets) {
      List<ExerciseSetData> exerciseSetData = await _getExerciseSetData(baseExerciseSet);
      exerciseSets.add(ExerciseSet.fromBase(
        baseExerciseSet: baseExerciseSet,
        data: exerciseSetData,
      ));
    }

    return exerciseSets;
  }

  Future<List<ExerciseSetData>> _getExerciseSetData(BaseExerciseSet exerciseSet) async {
    List<BaseExerciseSetData> baseExerciseSetDataList =
        await exerciseSetDataDao.getByExerciseSetId(exerciseSet.id!);
    return baseExerciseSetDataList
        .map((baseData) => ExerciseSetData(
            id: baseData.id,
            value: baseData.value,
            fieldType: baseData.fieldType,
            exerciseSetId: baseData.exerciseSetId))
        .toList();
  }
}
