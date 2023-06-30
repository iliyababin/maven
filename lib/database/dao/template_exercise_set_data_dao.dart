import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class TemplateExerciseSetDataDao {
  @insert
  Future<int> add(TemplateExerciseSetData templateExerciseSetData);

  @Query('SELECT * FROM template_exercise_set_data')
  Future<List<TemplateExerciseSetData>> getAll();

  @Query('SELECT * FROM template_exercise_set_data WHERE exercise_set_id = :exerciseSetId')
  Future<List<TemplateExerciseSetData>> getByExerciseSetId(int exerciseSetId);

  @update
  Future<int> modify(TemplateExerciseSetData templateExerciseSetData);

  @delete
  Future<int> remove(TemplateExerciseSetData templateExerciseSetData);
}