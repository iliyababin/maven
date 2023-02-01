
import 'package:floor/floor.dart';

import '../model/template_folder.dart';

@dao
abstract class TemplateFolderDao {

  @insert
  Future<void> addTemplateFolder(TemplateFolder templateFolder);

  @insert
  Future<void> addTemplateFolders(List<TemplateFolder> templateFolders);

  @Query('SELECT * FROM template_folder WHERE template_folder_id = :templateFolderId')
  Future<TemplateFolder?> getTemplateFolder(int templateFolderId);

  @Query('SELECT * FROM template_folder ORDER BY sort_order ASC')
  Future<List<TemplateFolder>> getTemplateFolders();

  @Query('SELECT * FROM template_folder ORDER BY sort_order ASC')
  Stream<List<TemplateFolder>> getTemplateFoldersAsStream();

  @update
  Future<void> updateTemplateFolder(TemplateFolder templateFolder);

  @delete
  Future<void> deleteTemplateFolder(TemplateFolder templateFolder);

}