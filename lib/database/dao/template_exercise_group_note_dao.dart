
import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class TemplateExerciseGroupNoteDao {
  @insert
  Future<int> add(TemplateExerciseGroupNote templateExerciseGroupNote);

  @Query('SELECT * FROM template_exercise_group_note')
  Future<List<TemplateExerciseGroupNote>> getAll();

  @Query('SELECT * FROM template_exercise_group_note WHERE exercise_group_id = :templateExerciseGroupId')
  Future<List<TemplateExerciseGroupNote>> getByTemplateExerciseGroupId(int templateExerciseGroupId);

  @update
  Future<int> modify(TemplateExerciseGroupNote templateExerciseGroupNote);

  @delete
  Future<int> remove(TemplateExerciseGroupNote templateExerciseGroupNote);
}