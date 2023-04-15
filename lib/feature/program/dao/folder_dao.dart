import 'package:floor/floor.dart';

import '../model/folder.dart';

@dao
abstract class FolderDao {
  @insert
  Future<int> addFolder(Folder folder);
}