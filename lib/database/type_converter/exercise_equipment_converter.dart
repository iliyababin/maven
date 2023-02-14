import 'package:Maven/feature/workout/common/model/exercise_equipment.dart';
import 'package:floor/floor.dart';

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