import 'package:floor/floor.dart';

import '../model/template_exercise_set.dart';

@dao
abstract class TemplateExerciseSetDao {
  @insert
  Future<int> add(TemplateExerciseSet templateExerciseSet);

  @Query('SELECT * FROM template_exercise_set')
  Future<List<TemplateExerciseSet>> getAll();

  @Query('SELECT * FROM template_exercise_set WHERE exercise_group_id = :templateExerciseGroupId')
  Future<List<TemplateExerciseSet>> getByTemplateExerciseGroupId(int templateExerciseGroupId);

  @update
  Future<int> modify(TemplateExerciseSet templateExerciseSet);

  @delete
  Future<int> remove(TemplateExerciseSet templateExerciseSet);
}