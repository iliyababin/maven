import 'package:equatable/equatable.dart';

class TemplateFolder extends Equatable{
  int? templateFolderId;
  String name;
  int expanded;
  int? sortOrder;


  TemplateFolder({
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

  @override
  List<Object?> get props => [templateFolderId, name, expanded, sortOrder];
}