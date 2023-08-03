import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class ProgramFolderDao {
  @insert
  Future<int> addProgramFolder(ProgramFolder programFolder);

  @Query('SELECT * FROM program_folder WHERE id = :id')
  Future<ProgramFolder?> getProgramFolder(int id);

  @Query('SELECT * FROM program_folder')
  Future<List<ProgramFolder>> getProgramFolders();

  @Query('SELECT * FROM program_folder WHERE program_id = :programId')
  Future<List<ProgramFolder>> getProgramFoldersByProgramId(int programId);

  @update
  Future<int> updateProgramFolder(ProgramFolder programFolder);

  @delete
  Future<int> deleteProgramFolder(ProgramFolder programFolder);
}
