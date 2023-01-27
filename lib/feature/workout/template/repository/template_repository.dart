

import '../../../../common/model/template.dart';

abstract class TemplateRepository {

  Future<int> addTemplate(Template template);

  Future<Template?> getTemplate(int templateId);

  Future<List<Template>> getTemplates();

  Future<int> updateTemplate(Template template);

  Future<void> deleteTemplate(int templateId);
}