import 'package:floor/floor.dart';

import '../../feature/exercise/model/exercise_type.dart';



class ExerciseTypeConverter extends TypeConverter<ExerciseType, String> {
  @override
  ExerciseType decode(String databaseValue) {
    return ExerciseTypes.fromName(databaseValue)!;
  }

  @override
  String encode(ExerciseType value) {
    return value.name;
  }
}