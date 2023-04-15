import 'package:floor/floor.dart';

import '../../template/model/template.dart';
import 'folder.dart';

@Entity(
  tableName: 'tracked_template',
  foreignKeys: [
    ForeignKey(
      childColumns: ['folder_id'],
      parentColumns: ['folder_id'],
      entity: Folder,
    ),
  ],
)
class TrackedTemplate extends Template {
  const TrackedTemplate({
    super.templateId,
    required super.name,
    super.sortOrder,
    required this.folderId,
  });

  @ColumnInfo(name: 'folder_id')
  final int folderId;
}