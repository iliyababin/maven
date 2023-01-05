import 'package:equatable/equatable.dart';

class Workout extends Equatable{
   int? workoutId;
   String name;
   int? sortOrder;
   int? workoutFolderId;


  Workout({
    this.workoutId,
    required this.name,
    this.sortOrder,
    this.workoutFolderId,
  });

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
    workoutId: json["workoutId"],
    name: json["name"],
    sortOrder: json["sortOrder"],
    workoutFolderId: json["workoutFolderId"],
  );

  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'name': name,
      'sortOrder': sortOrder,
      'workoutFolderId': workoutFolderId,
    };
  }

  @override
  List<Object?> get props => [workoutId, name, sortOrder, workoutFolderId];
}