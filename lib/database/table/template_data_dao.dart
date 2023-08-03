import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class TemplateDataDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(TemplateData templateData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<TemplateData> templateData);

  @Query('SELECT * FROM template_data WHERE id = :templateDataId')
  Future<TemplateData?> get(int templateDataId);

  @Query('SELECT * FROM template_data ORDER BY sort ASC')
  Future<List<TemplateData>> getAll();

  @Query('SELECT * FROM template_data WHERE routine_id = :routineId')
  Future<TemplateData?> getByRoutineId(int routineId);

  @update
  Future<int> modify(TemplateData templateData);

  @delete
  Future<int> remove(TemplateData templateData);
}
