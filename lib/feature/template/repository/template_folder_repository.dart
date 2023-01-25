
import 'package:Maven/common/model/workout_folder.dart';

abstract class TemplateFolderRepository {

  Future<int> addTemplateFolder(TemplateFolder templateFolder);

  Future<TemplateFolder?> getTemplateFolder(int templateFolderId);

  Future<List<TemplateFolder>> getTemplateFolders();

}