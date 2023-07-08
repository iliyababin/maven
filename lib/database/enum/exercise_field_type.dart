import 'package:maven/common/common.dart';

import '../../feature/exercise/exercise.dart';

enum ExerciseFieldType {
  assisted,
  reps,
  distance,
  duration,
  weight,
  weighted,
  bodyWeight;
}

extension ExerciseFieldTypeExtension on ExerciseFieldType {
  String generateTitle(ExerciseGroup exerciseGroup) {
    switch (this) {
      case ExerciseFieldType.weight:
        return exerciseGroup.weightUnit!.name;
      case ExerciseFieldType.reps:
        return name.capitalize;
      case ExerciseFieldType.distance:
        return exerciseGroup.distanceUnit!.name.capitalize;
      case ExerciseFieldType.assisted:
        return '- ${exerciseGroup.weightUnit!.name}';
      case ExerciseFieldType.weighted:
        return '+ ${exerciseGroup.weightUnit!.name}';
      case ExerciseFieldType.duration:
        return 'Duration';
      default:
        return '';
    }
  }
}