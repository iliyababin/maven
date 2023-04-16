import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../program/model/folder.dart';


@Entity(
  tableName: 'template',
  primaryKeys: [
    'template_id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['folder_id'],
      parentColumns: ['folder_id'],
      entity: Folder,
    ),
  ],
)
class Template extends Equatable {
  const Template({
    this.templateId,
    required this.name,
    this.sortOrder,
    this.folderId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'template_id')
  final int? templateId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'sort_order')
  final int? sortOrder;

  @ColumnInfo(name: 'folder_id')
  final int? folderId;

  Template copyWith({
    int? templateId,
    String? name,
    int? sortOrder,
    int? folderId,
  }) {
    return Template(
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      folderId: folderId ?? this.folderId,
    );
  }

  @override
  String toString() {
    return 'Template{templateId: $templateId, name: $name, sortOrder: $sortOrder}';
  }

  @override
  List<Object?> get props => [
    templateId,
    name,
    sortOrder,
    folderId,
  ];
}