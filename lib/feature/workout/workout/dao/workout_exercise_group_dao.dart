import 'package:floor/floor.dart';

import '../../../../common/model/workout_exercise_group.dart';

@dao
abstract class WorkoutExerciseGroupDao {

  @insert
  Future<int> addWorkoutExerciseGroup(WorkoutExerciseGroup workoutExerciseGroup);

  @Query('SELECT * FROM workout_exercise_group')
  Future<List<WorkoutExerciseGroup>> getWorkoutExerciseGroups();

  @Query('SELECT * FROM workout_exercise_group WHERE workout_id = :workoutId')
  Future<List<WorkoutExerciseGroup>> getWorkoutExerciseGroupsByWorkoutId(int workoutId);

  @delete
  Future<void> deleteWorkoutExerciseGroup(WorkoutExerciseGroup workoutExerciseGroup);

  @Query('DELETE * FROM workout_exercise_group WHERE workout_id = :workoutId')
  Future<void> deleteWorkoutExerciseGroupsByWorkoutId(int workoutId);

}