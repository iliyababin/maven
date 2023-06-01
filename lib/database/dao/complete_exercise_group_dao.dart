
import 'package:floor/floor.dart';

import '../model/complete_exercise_group.dart';

@dao
abstract class CompleteExerciseGroupDao {
  @insert
  Future<int> addCompleteExerciseGroup(CompleteExerciseGroup completeExerciseGroup);

  @Query('SELECT * FROM complete_exercise_group')
  Future<List<CompleteExerciseGroup>> getCompleteExerciseGroups();

  @Query('SELECT * FROM complete_exercise_group WHERE complete_exercise_group_id = :completeExerciseGroupId')
  Future<CompleteExerciseGroup?> getCompleteExerciseGroup(int completeExerciseGroupId);

  @Query('SELECT * FROM complete_exercise_group WHERE complete_id = :completeId')
  Future<List<CompleteExerciseGroup>> getCompleteExerciseGroupsByCompleteId(int completeId);

  @Query('SELECT * FROM complete_exercise_group WHERE exercise_id = :exerciseId')
  Future<List<CompleteExerciseGroup>> getCompleteExerciseGroupsByExerciseId(int exerciseId);

  @update
  Future<int> updateCompleteExerciseGroup(CompleteExerciseGroup exerciseId);

  @delete
  Future<int> deleteCompleteExerciseGroup(CompleteExerciseGroup completeExerciseGroup);
}