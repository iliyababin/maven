import 'package:floor/floor.dart';

import '../../../database/model/template.dart';

@dao
abstract class TemplateDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addTemplate(Template template);

  @insert
  Future<void> addTemplates(List<Template> templates);

  @Query('SELECT * FROM template WHERE template_id = :templateId')
  Future<Template?> getTemplate(int templateId);

  @Query('SELECT * FROM template ORDER BY sort_order ASC')
  Future<List<Template>> getTemplates();

  @Query('SELECT * FROM template WHERE folder_id = :folderId ORDER BY sort_order ASC ')
  Future<List<Template>> getTemplatesByFolderId(int folderId);

  @Query('SELECT * FROM template WHERE folder_id is null ORDER BY sort_order ASC')
  Stream<List<Template>> getTemplatesAsStream();

  @Query('SELECT sort_order FROM template')
  Future<List<int>> getHighestSortOrder();

  @update
  Future<void> updateTemplate(Template template);

  @delete
  Future<void> deleteTemplate(Template template);
}