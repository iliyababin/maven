import 'package:floor/floor.dart';

import '../../feature/exercise/model/exercise_equipment.dart';

class ExerciseEquipmentConverter extends TypeConverter<ExerciseEquipment, int> {
  @override
  ExerciseEquipment decode(int databaseValue) {
    return getExerciseEquipmentById(databaseValue)!;
  }

  @override
  int encode(ExerciseEquipment value) {
    return value.exerciseEquipmentId;
  }
}