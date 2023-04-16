
import 'package:floor/floor.dart';

import '../model/template_tracker.dart';

@dao
abstract class TemplateTrackerDao {
  @insert
  Future<int> addTemplateTracker(TemplateTracker templateTracker);

  @Query('SELECT * FROM tracked_template WHERE folder_id = :folderId')
  Future<List<TemplateTracker>> getTemplateTrackersByFolderId(int folderId);
}