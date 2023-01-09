import 'package:equatable/equatable.dart';

class WorkoutFolder extends Equatable{
  int? workoutFolderId;
  String name;
  int expanded;
  int? sortOrder;


  WorkoutFolder({
    this.workoutFolderId,
    required this.name,
    required this.expanded,
    this.sortOrder,
  });

  factory WorkoutFolder.fromMap(Map<String, dynamic> json) => WorkoutFolder(
    workoutFolderId: json["workoutFolderId"],
    name: json["name"],
    expanded: json["expanded"],
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toMap() {
    return {
      'workoutFolderId': workoutFolderId,
      'name': name,
      'expanded': expanded,
      'sortOrder': sortOrder,
    };
  }

  @override
  List<Object?> get props => [workoutFolderId, name, expanded, sortOrder];
}