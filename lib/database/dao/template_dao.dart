import 'package:floor/floor.dart';

import '../model/template.dart';

@dao
abstract class TemplateDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addTemplate(Template template);

  @insert
  Future<void> addTemplates(List<Template> templates);

  @Query('SELECT * FROM template WHERE id = :templateId')
  Future<Template?> getTemplate(int templateId);

  // ORDER BY order ASC
  @Query('SELECT * FROM template')
  Future<List<Template>> getTemplates();


  @Query('SELECT sort_order FROM template')
  Future<List<int>> getHighestSortOrder();

  @update
  Future<void> updateTemplate(Template template);

  @delete
  Future<void> deleteTemplate(Template template);
}