
import 'package:floor/floor.dart';

import '../model/tracked_template.dart';

@dao
abstract class TrackedTemplateDao {
  @insert
  Future<int> addTrackedTemplate(TrackedTemplate trackedTemplate);
}