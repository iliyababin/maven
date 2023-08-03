import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class ProgramTemplateDao {
  @insert
  Future<int> addProgramTemplate(ProgramTemplate programTemplate);

  @Query('SELECT * FROM program_template WHERE id = :id')
  Future<ProgramTemplate?> getProgramTemplate(int id);

  @Query('SELECT * FROM program_template')
  Future<List<ProgramTemplate>> getProgramTemplates();

  @Query('SELECT * FROM program_template WHERE folder_id = :folderId')
  Future<List<ProgramTemplate>> getProgramTemplatesByFolderId(int folderId);

  @update
  Future<int> updateProgramTemplate(ProgramTemplate programTemplate);

  @delete
  Future<int> deleteProgramTemplate(ProgramTemplate programTemplate);
}