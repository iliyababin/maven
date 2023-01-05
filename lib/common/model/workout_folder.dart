import 'package:equatable/equatable.dart';

class WorkoutFolder extends Equatable{
  int? workoutFolderId;
  String name;
  int? sortOrder;


  WorkoutFolder({
    this.workoutFolderId,
    required this.name,
    this.sortOrder,
  });

  factory WorkoutFolder.fromMap(Map<String, dynamic> json) => WorkoutFolder(
    workoutFolderId: json["workoutFolderId"],
    name: json["name"],
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toMap() {
    return {
      'workoutFolderId': workoutFolderId,
      'name': name,
      'sortOrder': sortOrder,
    };
  }

  @override
  List<Object?> get props => [workoutFolderId, name, sortOrder];
}