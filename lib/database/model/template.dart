import 'package:maven/database/model/template_tracker.dart';
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
    required this.description,
    this.sortOrder,
    this.folderId,
    this.templateTracker,
  });

  const Template.empty() : this(
    templateId: null,
    name: 'Error: Empty Template',
    description: 'Error: Empty Template',
  );

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'template_id')
  final int? templateId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String description;

  @ColumnInfo(name: 'sort_order')
  final int? sortOrder;

  @ColumnInfo(name: 'folder_id')
  final int? folderId;

  @ignore
  final TemplateTracker? templateTracker;

  Template copyWith({
    int? templateId,
    String? name,
    String? description,
    int? sortOrder,
    int? folderId,
    TemplateTracker? templateTracker,
  }) {
    return Template(
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      folderId: folderId ?? this.folderId,
      templateTracker: templateTracker ?? this.templateTracker,
    );
  }

  @override
  String toString() {
    return 'Template{templateId: $templateId, name: $name, description: $description, sortOrder: $sortOrder, folderId: $folderId, templateTracker: $templateTracker}';
  }

  @override
  List<Object?> get props => [
    templateId,
    name,
    description,
    sortOrder,
    folderId,
    templateTracker,
  ];
}