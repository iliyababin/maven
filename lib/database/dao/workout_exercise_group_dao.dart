import 'package:floor/floor.dart';

import '../model/workout_exercise_group.dart';

@dao
abstract class WorkoutExerciseGroupDao {

  @insert
  Future<int> addWorkoutExerciseGroup(WorkoutExerciseGroup workoutExerciseGroup);

  @Query('SELECT * FROM workout_exercise_group WHERE workout_exercise_group_id = :workoutExerciseGroupId')
  Future<WorkoutExerciseGroup?> getWorkoutExerciseGroup(int workoutExerciseGroupId);

  @Query('SELECT * FROM workout_exercise_group')
  Future<List<WorkoutExerciseGroup>> getWorkoutExerciseGroups();

  @Query('SELECT * FROM workout_exercise_group')
  Stream<List<WorkoutExerciseGroup>> getWorkoutExerciseGroupsAsStream();
  
  @delete
  Future<void> deleteWorkoutExerciseGroup(WorkoutExerciseGroup workoutExerciseGroup);

  // TODO: Floor does not update streams using Query annotation
  @Query('DELETE * FROM workout_exercise_group WHERE workout_id = :workoutId')
  Future<void> deleteWorkoutExerciseGroupsByWorkoutId(int workoutId);

  @update
  Future<void> updateWorkoutExerciseGroup(WorkoutExerciseGroup workoutExerciseGroup);
}