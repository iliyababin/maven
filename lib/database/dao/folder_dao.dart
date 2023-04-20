import 'package:floor/floor.dart';

import '../model/folder.dart';

@dao
abstract class FolderDao {
  @insert
  Future<int> addFolder(Folder folder);

  @Query('SELECT * FROM folder WHERE program_id = :programId')
  Future<List<Folder>> getFoldersByProgramId(int programId);
}