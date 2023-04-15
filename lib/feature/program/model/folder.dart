import 'package:Maven/feature/program/model/tracked_template.dart';
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
    this.trackedTemplates = const [],
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'folder_id')
  final int? folderId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'program_id')
  final int programId;

  @ignore
  final List<TrackedTemplate> trackedTemplates;

  Folder copyWith({
    int? folderId,
    String? name,
    int? programId,
    List<TrackedTemplate>? trackedTemplates,
  }) {
    return Folder(
      folderId: folderId ?? this.folderId,
      name: name ?? this.name,
      programId: programId ?? this.programId,
      trackedTemplates: trackedTemplates ?? this.trackedTemplates,
    );
  }
}