
import '../../common/dto/exercise_set.dart';
import '../../common/model/exercise.dart';
import '../../template/dao/exercise_dao.dart';
import '../dao/workout_dao.dart';
import '../dao/workout_exercise_group_dao.dart';
import '../dao/workout_exercise_set_dao.dart';
import '../model/workout.dart';
import '../model/workout_exercise_group.dart';
import '../model/workout_exercise_set.dart';

class WorkoutDto {
  Workout workout;
  List<WorkoutGroupDto> workoutGroupDtos;

  WorkoutDto({
    required this.workout,
    required this.workoutGroupDtos,
  });
}

class WorkoutGroupDto {
  WorkoutExerciseGroup workoutExerciseGroup;
  List<ExerciseSet> exerciseSets;
  Exercise exercise;

  WorkoutGroupDto({
    required this.workoutExerciseGroup,
    required this.exerciseSets,
    required this.exercise,
  });
}

class WorkoutService {
  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;
  final ExerciseDao exerciseDao;

  const WorkoutService({
    required this.workoutDao,
    required this.workoutExerciseGroupDao,
    required this.workoutExerciseSetDao,
    required this.exerciseDao,
  });

  Future<WorkoutDto?> getWorkoutDto() async {
    Workout? workout = await workoutDao.getPausedWorkout();
    if(workout == null) return null;

    List<WorkoutExerciseGroup> workoutExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(workout.workoutId!);

    List<WorkoutGroupDto> workoutGroupDtos = [];

    for(WorkoutExerciseGroup workoutExerciseGroup in workoutExerciseGroups){
      List<WorkoutExerciseSet> workoutExerciseSets = await workoutExerciseSetDao.getWorkoutExerciseSetsByWorkoutExerciseGroupId(workoutExerciseGroup.workoutExerciseGroupId!);
      List<ExerciseSet> exerciseSets = workoutExerciseSets.map((workoutExerciseSet) =>
        ExerciseSet(
          exerciseSetId: workoutExerciseSet.workoutExerciseSetId!,
          option1: workoutExerciseSet.option_1,
          option2: workoutExerciseSet.option_2,
          checked: workoutExerciseSet.checked
        )
      ).toList();
      Exercise? exercise = await exerciseDao.getExercise(workoutExerciseGroup.exerciseId);
      if(exercise == null) throw UnimplementedError('Exercise does not exist');
      workoutGroupDtos.add(
        WorkoutGroupDto(
          workoutExerciseGroup: workoutExerciseGroup,
          exerciseSets: exerciseSets,
          exercise: exercise
        )
      );
    }

    return WorkoutDto(
      workout: workout,
      workoutGroupDtos: workoutGroupDtos
    );
  }

  Future<int> addWorkoutExerciseGroup({
    required int workoutId,
    required Exercise exercise,
  }) async {
    return workoutExerciseGroupDao.addWorkoutExerciseGroup(
      WorkoutExerciseGroup(
        workoutId: workoutId,
        exerciseId: exercise.exerciseId,
      ),
    );
  }

  Future<WorkoutExerciseGroup?> getWorkoutExerciseGroup(int workoutExerciseGroupId) async {
    return await workoutExerciseGroupDao.getWorkoutExerciseGroup(workoutExerciseGroupId);
  }


  Future<WorkoutExerciseSet?> addWorkoutExerciseSet({
    required int workoutId,
    required int workoutExerciseGroupId,
  }) async {
    WorkoutExerciseGroup? workoutExerciseGroup = await workoutExerciseGroupDao.getWorkoutExerciseGroup(workoutExerciseGroupId);
    Exercise? exercise = await exerciseDao.getExercise(workoutExerciseGroup!.exerciseId);

    print(exercise?.exerciseType.exerciseTypeOption2 == null ? null : 0);
    int workoutExerciseSetId = await workoutExerciseSetDao.addWorkoutExerciseSet(
      WorkoutExerciseSet(
        workoutId: workoutId,
        workoutExerciseGroupId: workoutExerciseGroupId,
        option_1: 0,
        option_2: exercise?.exerciseType.exerciseTypeOption2 == null ? null : 0,
        checked: 0,
      ),
    );
    return await workoutExerciseSetDao.getWorkoutExerciseSet(workoutExerciseSetId);
  }

  Future<void> deleteWorkoutExerciseSet({
    required int workoutExerciseSetId
  }) async{
    WorkoutExerciseSet? workoutExerciseSet = await workoutExerciseSetDao.getWorkoutExerciseSet(workoutExerciseSetId);
    workoutExerciseSetDao.deleteWorkoutExerciseSet(workoutExerciseSet!);
  }

  Future<void> updateWorkoutExerciseSet({
    required ExerciseSet exerciseSet,
    required int workoutId,
    required int workoutExerciseGroupId,
  }) async {
    workoutExerciseSetDao.updateWorkoutExerciseSet(
      WorkoutExerciseSet(
        workoutExerciseSetId: exerciseSet.exerciseSetId,
        option_1: exerciseSet.option1,
        option_2: exerciseSet.option2,
        checked: exerciseSet.checked ?? 0,
        workoutId: workoutId,
        workoutExerciseGroupId: workoutExerciseGroupId,
      )
    );
  }

  Future<void> changeWorkoutName(String workoutName) async {
    if(workoutName.isEmpty) workoutName = "Untitled Workout";
    Workout? workout = await workoutDao.getPausedWorkout();
    workoutDao.updateWorkout(workout!.copyWith(name: workoutName));
  }

  Future<WorkoutExerciseSet?> getWorkoutExerciseSet(int workoutExerciseSetId) async {
    return await workoutExerciseSetDao.getWorkoutExerciseSet(workoutExerciseSetId);
  }


}