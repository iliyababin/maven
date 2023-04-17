
import 'package:floor/floor.dart';

import '../../../database/model/template_tracker.dart';

@dao
abstract class TemplateTrackerDao {
  @insert
  Future<int> addTemplateTracker(TemplateTracker templateTracker);

  @Query('SELECT * FROM template_tracker WHERE folder_id = :folderId')
  Future<List<TemplateTracker>> getTemplateTrackersByFolderId(int folderId);

  @Query('SELECT * FROM template_tracker WHERE template_id = :templateId')
  Future<TemplateTracker?> getTemplateTrackerByTemplateId(int templateId);

  @update
  Future<int> updateTemplateTracker(TemplateTracker templateTracker);
}