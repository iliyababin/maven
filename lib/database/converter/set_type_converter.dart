import 'package:floor/floor.dart';

import '../database.dart';

class SetTypeConverter extends TypeConverter<ExerciseSetType, String> {
  @override
  ExerciseSetType decode(String databaseValue) {
    return ExerciseSetType.fromName(databaseValue);
  }

  @override
  String encode(ExerciseSetType value) {
    return value.name;
  }
}