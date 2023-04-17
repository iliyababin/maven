import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import 'program.dart';
import 'template.dart';

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
class Folder extends Equatable {
  const Folder({
    this.folderId,
    required this.name,
    required this.programId,
    this.templates = const [],
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'folder_id')
  final int? folderId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'program_id')
  final int programId;

  @ignore
  final List<Template> templates;

  Folder copyWith({
    int? folderId,
    String? name,
    int? programId,
    List<Template>? templates,
  }) {
    return Folder(
      folderId: folderId ?? this.folderId,
      name: name ?? this.name,
      programId: programId ?? this.programId,
      templates: templates ?? this.templates,
    );
  }

  @override
  List<Object?> get props => [
    folderId,
    name,
    programId,
    templates,
  ];
}