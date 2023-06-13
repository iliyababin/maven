
import 'package:floor/floor.dart';

import '../model/template_exercise_group.dart';


@dao
abstract class TemplateExerciseGroupDao {
  @insert
  Future<int> addTemplateExerciseGroup(TemplateExerciseGroup templateExerciseGroup);

  @Query('SELECT * FROM template_exercise_group')
  Future<List<TemplateExerciseGroup>> getTemplateExerciseGroups();

  @Query('SELECT * FROM template_exercise_group WHERE id = :templateId')
  Future<List<TemplateExerciseGroup>> getTemplateExerciseGroupsByTemplateId(int templateId);

  @update
  Future<void> updateTemplateExerciseGroup(TemplateExerciseGroup templateExerciseGroup);

  @delete
  Future<void> deleteTemplateExerciseGroup(TemplateExerciseGroup templateExerciseGroup);
}