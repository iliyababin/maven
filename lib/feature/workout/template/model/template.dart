import 'package:Maven/feature/workout/template/model/template_folder.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'template',
  foreignKeys: [
    ForeignKey(
      childColumns: ['template_folder_id'],
      parentColumns: ['template_folder_id'],
      entity: TemplateFolder
    )
  ]
)
class Template extends Equatable {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'template_id')
  final int? templateId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'sort_order')
  final int? sortOrder;

  @ColumnInfo(name: 'template_folder_id')
  final int? templateFolderId;


  const Template({
    this.templateId,
    required this.name,
    this.sortOrder,
    this.templateFolderId,
  });

  factory Template.fromMap(Map<String, dynamic> json) => Template(
    templateId: json["templateId"],
    name: json["name"],
    sortOrder: json["sortOrder"],
    templateFolderId: json["templateFolderId"],
  );

  Map<String, dynamic> toMap() {
    return {
      'templateId': templateId,
      'name': name,
      'sortOrder': sortOrder,
      'templateFolderId': templateFolderId,
    };
  }

  Template copyWith({
    int? templateId,
    String? name,
    int? sortOrder,
    int? templateFolderId,
  }) {
    return Template(
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      templateFolderId: templateFolderId ?? this.templateFolderId,
    );
  }

  @override
  List<Object?> get props => [templateId, name, sortOrder, templateFolderId];
}