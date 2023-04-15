
import 'package:floor/floor.dart';

import '../model/tracked_template.dart';

@dao
abstract class TrackedTemplateDao {
  @insert
  Future<int> addTrackedTemplate(TrackedTemplate trackedTemplate);

  @Query('SELECT * FROM tracked_template WHERE folder_id = :folderId')
  Future<List<TrackedTemplate>> getTrackedTemplatesByFolderId(int folderId);
}