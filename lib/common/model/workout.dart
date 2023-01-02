import 'package:equatable/equatable.dart';

class Workout extends Equatable{
   int? workoutId;
   String name;
   int? sortOrder;


  Workout({
    this.workoutId,
    required this.name,
    this.sortOrder,
  });

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
    workoutId: json["workoutId"],
    name: json["name"],
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'name': name,
      'sortOrder': sortOrder,
    };
  }



  @override
  String toString() {
    return 'Workout{workoutId: $workoutId, name: $name}';
  }

  @override
  List<Object?> get props => [workoutId, name, sortOrder];
}