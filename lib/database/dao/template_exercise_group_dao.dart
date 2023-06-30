
import 'package:floor/floor.dart';

import '../model/template_exercise_group.dart';


@dao
abstract class TemplateExerciseGroupDao {
  @insert
  Future<int> add(TemplateExerciseGroup templateExerciseGroup);

  @Query('SELECT * FROM template_exercise_group')
  Future<List<TemplateExerciseGroup>> getAll();

  @Query('SELECT * FROM template_exercise_group WHERE template_id = :templateId')
  Future<List<TemplateExerciseGroup>> getByTemplateId(int templateId);

  @update
  Future<int> modify(TemplateExerciseGroup templateExerciseGroup);

  @delete
  Future<int> remove(TemplateExerciseGroup templateExerciseGroup);
}