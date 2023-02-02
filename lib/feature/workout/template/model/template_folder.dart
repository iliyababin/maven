import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'template_folder')
class TemplateFolder extends Equatable {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'template_folder_id')
  final int? templateFolderId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'expanded')
  final int expanded;

  @ColumnInfo(name: 'sort_order')
  final int? sortOrder;


  const TemplateFolder({
    this.templateFolderId,
    required this.name,
    required this.expanded,
    this.sortOrder,
  });

  factory TemplateFolder.fromMap(Map<String, dynamic> json) => TemplateFolder(
    templateFolderId: json["templateFolderId"],
    name: json["name"],
    expanded: json["expanded"],
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toMap() {
    return {
      'templateFolderId': templateFolderId,
      'name': name,
      'expanded': expanded,
      'sortOrder': sortOrder,
    };
  }

  TemplateFolder copyWith({
    int? templateFolderId,
    String? name,
    int? expanded,
    int? sortOrder,
  }) {
    return TemplateFolder(
      templateFolderId: templateFolderId ?? this.templateFolderId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      expanded: expanded ?? this.expanded,
    );
  }

  @override
  List<Object?> get props => [templateFolderId, name, expanded, sortOrder];
}