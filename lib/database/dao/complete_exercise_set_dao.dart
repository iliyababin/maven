
import 'package:floor/floor.dart';

import '../model/complete_exercise_set.dart';

@dao
abstract class CompleteExerciseSetDao {
  @insert
  Future<int> addCompleteExerciseSet(CompleteExerciseSet completeExerciseSet);

  @Query('SELECT * FROM complete_exercise_set')
  Future<List<CompleteExerciseSet>> getCompleteExerciseSets();

  @Query('SELECT * FROM complete_exercise_set WHERE complete_exercise_set_id = :completeExerciseSetId')
  Future<CompleteExerciseSet?> getCompleteExerciseSet(int completeExerciseSetId);

  @Query('SELECT * FROM complete_exercise_set WHERE complete_exercise_group_id = :completeExerciseGroupId')
  Future<List<CompleteExerciseSet>> getCompleteExerciseSetsByCompleteExerciseGroupId(int completeExerciseGroupId);

  @Query('SELECT * FROM complete_exercise_set WHERE complete_id = :completeId')
  Future<List<CompleteExerciseSet>> getCompleteExerciseSetsByCompleteId(int completeId);

  @update
  Future<int> updateCompleteExerciseSet(CompleteExerciseSet completeExerciseSet);

  @delete
  Future<int> deleteCompleteExerciseSet(CompleteExerciseSet completeExerciseSet);
}