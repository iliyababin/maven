import 'package:floor/floor.dart';

import 'program.dart';

@Entity(
  tableName: 'folder',
  primaryKeys: [
    'folder_id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['program_id'],
      parentColumns: ['program_id'],
      entity: Program,
    ),
  ],
)
class Folder {
  const Folder({
    this.folderId,
    required this.name,
    required this.programId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'folder_id')
  final int? folderId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'program_id')
  final int programId;
}