import 'package:equatable/equatable.dart';

class Template extends Equatable{
   int? templateId;
   String name;
   int? sortOrder;
   int? templateFolderId;


  Template({
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

  @override
  List<Object?> get props => [templateId, name, sortOrder, templateFolderId];
}