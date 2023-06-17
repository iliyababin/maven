import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class WorkoutExerciseSetDataDao {
  @insert
  Future<int> addWorkoutExerciseSetData(WorkoutExerciseSetData workoutExerciseSetData);

  @Query('SELECT * FROM workout_exercise_set_data')
  Future<List<WorkoutExerciseSetData>> getWorkoutExerciseSetData();

  @Query('SELECT * FROM workout_exercise_set_data WHERE exercise_set_id = :exerciseSetId')
  Future<List<WorkoutExerciseSetData>> getWorkoutExerciseSetDataByExerciseSetId(int exerciseSetId);

  @update
  Future<int> updateWorkoutExerciseSetData(WorkoutExerciseSetData workoutExerciseSetData);

  @delete
  Future<int> deleteWorkoutExerciseSetData(WorkoutExerciseSetData workoutExerciseSetData);
}