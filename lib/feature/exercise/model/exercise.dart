import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import 'exercise_equipment.dart';
import 'exercise_type.dart';

@Entity(
  tableName: 'exercise',
  primaryKeys: [
    'exercise_id',
  ],
)
class Exercise extends Equatable {

  @ColumnInfo(name: 'exercise_id')
  @PrimaryKey(autoGenerate: true)
  final int exerciseId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'muscle')
  final String muscle;

  @ColumnInfo(name: 'picture')
  final String picture;

  @ColumnInfo(name: 'exercise_type')
  final ExerciseType exerciseType;

  @ColumnInfo(name: 'exercise_equipment')
  final ExerciseEquipment exerciseEquipment;

  const Exercise({
    required this.exerciseId,
    required this.name,
    required this.muscle,
    required this.picture,
    required this.exerciseType,
    required this.exerciseEquipment,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
    exerciseId: json["exerciseId"],
    name: json["name"],
    muscle: json["muscle"],
    picture: json["picture"],
    exerciseType: getExerciseTypes().firstWhere((exerciseType) => exerciseType.exerciseTypeId == json["exerciseType"]),
    exerciseEquipment: getExerciseEquipmentById(json["exerciseEquipment"])!,
  );

  @override
  List<Object?> get props => [
    exerciseId,
    name,
    muscle,
    picture,
    exerciseType,
    exerciseEquipment,
  ];
}


