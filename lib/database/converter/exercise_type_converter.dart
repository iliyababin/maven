import 'package:floor/floor.dart';

import '../../feature/exercise/model/exercise_type.dart';



class ExerciseTypeConverter extends TypeConverter<ExerciseType, int> {
  @override
  ExerciseType decode(int databaseValue) {
    return getExerciseTypes().firstWhere((exerciseType) => exerciseType.exerciseTypeId == databaseValue);
  }

  @override
  int encode(ExerciseType value) {
    return value.exerciseTypeId;
  }

}