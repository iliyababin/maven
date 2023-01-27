import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'template_repository.dart';

class TemplateRepositoryImpl implements TemplateRepository {

  final DBHelper _dbHelper;

  TemplateRepositoryImpl(this._dbHelper);

  @override
  Future<int> addTemplate(Template template) async {
    final Database db = await _dbHelper.database;
    var templateMap = template.toMap();
    int highestSortOrder = await _getTemplateWithHighestSortOrder() + 1;
    templateMap["sortOrder"] = highestSortOrder;
    return await db.insert(_dbHelper.TEMPLATE_TABLE, templateMap);
  }

  Future<int> _getTemplateWithHighestSortOrder() async {
    final Database db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(_dbHelper.TEMPLATE_TABLE, orderBy: 'sortOrder DESC');
    if (maps.isNotEmpty) {
      return Template.fromMap(maps.first).sortOrder ?? 0;
    }
    return 0;
  }

  @override
  Future<Template?> getTemplate(int templateId) async {
    final Database db = await _dbHelper.database;
    final template = await db.query(_dbHelper.TEMPLATE_TABLE, where: 'templateId = ?', whereArgs: [templateId]);
    return template.isNotEmpty ? Template.fromMap(template.first) : null;
  }

  @override
  Future<List<Template>> getTemplates() async {
    final Database db = await _dbHelper.database;
    var templates = await db.query(_dbHelper.TEMPLATE_TABLE, orderBy: 'sortOrder');
    List<Template> templateList = templates.isNotEmpty
        ? templates.map((c) => Template.fromMap(c)).toList()
        : [];
    return templateList;
  }

  @override
  Future<void> deleteTemplate(int templateId) {
    // TODO: implement deleteTemplate
    throw UnimplementedError();
  }

  @override
  Future<int> updateTemplate(Template template) async {
    final Database db = await _dbHelper.database;
    return await db.update(
      _dbHelper.TEMPLATE_TABLE,
      template.toMap(),
      where: 'templateId = ?',
      whereArgs: [template.templateId],
    );
  }

}