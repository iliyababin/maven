import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class TemplateExerciseSetDataDao {
  @insert
  Future<int> addTemplateExerciseSetData(TemplateExerciseSetData templateExerciseSetData);

  @Query('SELECT * FROM template_exercise_set_data')
  Future<List<TemplateExerciseSetData>> getTemplateExerciseSetData();

  @Query('SELECT * FROM template_exercise_set_data WHERE exercise_set_id = :exerciseSetId')
  Future<List<TemplateExerciseSetData>> getTemplateExerciseSetDataByExerciseSetId(int exerciseSetId);

  @update
  Future<int> updateTemplateExerciseSetData(TemplateExerciseSetData templateExerciseSetData);

  @delete
  Future<int> deleteTemplateExerciseSetData(TemplateExerciseSetData templateExerciseSetData);
}