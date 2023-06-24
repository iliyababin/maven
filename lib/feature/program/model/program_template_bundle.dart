import 'package:maven/feature/exercise/model/exercise_bundle.dart';

import '../../../database/database.dart';

class ProgramTemplateBundle {
  ProgramTemplateBundle({
    required this.programTemplate,
    required this.exerciseBundles,
  });

  ProgramTemplate programTemplate;
  List<ExerciseBundle> exerciseBundles;
}