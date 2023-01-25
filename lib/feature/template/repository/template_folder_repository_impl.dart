import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'template_folder_repository.dart';

class TemplateFolderRepositoryImpl implements TemplateFolderRepository {

  final DBHelper _dbHelper;

  TemplateFolderRepositoryImpl(this._dbHelper);

  @override
  Future<int> addTemplateFolder(TemplateFolder templateFolder) async {
    final Database db = await _dbHelper.database;
    Map<String, dynamic> templateFolderMap = templateFolder.toMap();
    int highestSortOrder = await _getTemplateFolderWithHighestSortOrder() + 1;
    templateFolderMap["sortOrder"] = highestSortOrder;
    return await db.insert(_dbHelper.TEMPLATE_FOLDER_TABLE, templateFolderMap);
  }

  Future<int> _getTemplateFolderWithHighestSortOrder() async {
    final Database db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(_dbHelper.TEMPLATE_FOLDER_TABLE, orderBy: 'sortOrder DESC');
    if (maps.isNotEmpty) {
      return TemplateFolder.fromMap(maps.first).sortOrder ?? 0;
    }
    return 0;
  }

  @override
  Future<TemplateFolder?> getTemplateFolder(int templateFolderId) {
    // TODO: implement getTemplateFolder
    throw UnimplementedError();
  }

  @override
  Future<List<TemplateFolder>> getTemplateFolders() async {
    final Database db = await _dbHelper.database;
    var templateFolders = await db.query(_dbHelper.TEMPLATE_FOLDER_TABLE, orderBy: 'sortOrder');
    List<TemplateFolder> templateFolderList = templateFolders.isNotEmpty
        ? templateFolders.map((c) => TemplateFolder.fromMap(c)).toList()
        : [];
    return templateFolderList;
  }

}