import 'package:floor/floor.dart';

import '../../feature/exercise/model/exercise_equipment.dart';

class EquipmentConverter extends TypeConverter<Equipment, int> {
  @override
  Equipment decode(int databaseValue) {
    return getEquipmentById(databaseValue)!;
  }

  @override
  int encode(Equipment value) {
    return value.equipmentId;
  }
}