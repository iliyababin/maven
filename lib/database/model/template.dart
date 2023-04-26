import 'package:Maven/database/model/template_tracker.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import 'folder.dart';


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
    this.templateTracker,
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

  @ignore
  final TemplateTracker? templateTracker;

  Template copyWith({
    int? templateId,
    String? name,
    int? sortOrder,
    int? folderId,
    TemplateTracker? templateTracker,
  }) {
    return Template(
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      folderId: folderId ?? this.folderId,
      templateTracker: templateTracker ?? this.templateTracker,
    );
  }

  @override
  String toString() {
    return 'Template(templateId: $templateId, name: $name, sortOrder: $sortOrder, folderId: $folderId, templateTracker: $templateTracker)';
  }

  @override
  List<Object?> get props => [
    templateId,
    name,
    sortOrder,
    folderId,
    templateTracker,
  ];
}