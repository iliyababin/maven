import 'package:Maven/feature/workout/common/model/exercise_type.dart';
import 'package:floor/floor.dart';

import 'exercise_equipment.dart';

@Entity(tableName: 'exercise')
class Exercise {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'exercise_id')
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
}


