import 'package:floor/floor.dart';

import '../model/template_exercise_set.dart';

@dao
abstract class TemplateExerciseSetDao {
  @insert
  Future<void> addTemplateExerciseSet(TemplateExerciseSet templateExerciseSet);

  @Query('SELECT * FROM template_exercise_set')
  Future<List<TemplateExerciseSet>> getExerciseSets();

  @Query('SELECT * FROM template_exercise_set WHERE template_exercise_group_id = :templateExerciseGroupId')
  Future<List<TemplateExerciseSet>> getTemplateExerciseSetsByTemplateExerciseGroupId(int templateExerciseGroupId);

  @delete
  Future<void> deleteTemplateExerciseSet(TemplateExerciseSet templateExerciseSet);

  @Query('DELETE FROM template_exercise_set WHERE template_id = :templateId')
  Future<void> deleteExerciseSetsByTemplateId(int templateId);
}