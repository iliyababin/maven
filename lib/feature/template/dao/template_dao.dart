import 'package:floor/floor.dart';

import '../model/template.dart';

@dao
abstract class TemplateDao {

  @insert
  Future<int> addTemplate(Template template);

  @insert
  Future<void> addTemplates(List<Template> templates);

  @Query('SELECT * FROM template WHERE template_id = :templateId')
  Future<Template?> getTemplate(int templateId);

  @Query('SELECT * FROM template ORDER BY sort_order ASC')
  Future<List<Template>> getTemplates();

  @Query('SELECT * FROM template WHERE template_folder_id = :templateFolderId')
  Future<List<Template>> getTemplatesByTemplateFolderId(int templateFolderId);

  @Query('SELECT * FROM template ORDER BY sort_order ASC')
  Stream<List<Template>> getTemplatesAsStream();

  @update
  Future<void> updateTemplate(Template template);

  @delete
  Future<void> deleteTemplate(Template template);
  
  @Query('DELETE FROM template WHERE template_id = :templateFolderId')
  Future<void> deleteTemplateByTemplateFolderId(int templateFolderId);
}