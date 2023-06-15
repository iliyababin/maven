import 'package:floor/floor.dart';

import '../model/template_exercise_set.dart';

@dao
abstract class TemplateExerciseSetDao {
  @insert
  Future<int> addTemplateExerciseSet(TemplateExerciseSet templateExerciseSet);

  @Query('SELECT * FROM template_exercise_set')
  Future<List<TemplateExerciseSet>> getExerciseSets();

  @Query('SELECT * FROM template_exercise_set WHERE exercise_group_id = :templateExerciseGroupId')
  Future<List<TemplateExerciseSet>> getTemplateExerciseSetsByTemplateExerciseGroupId(int templateExerciseGroupId);

  @update
  Future<void> updateTemplateExerciseSet(TemplateExerciseSet templateExerciseSet);

  @delete
  Future<void> deleteTemplateExerciseSet(TemplateExerciseSet templateExerciseSet);
}