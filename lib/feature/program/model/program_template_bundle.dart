
import '../../../database/database.dart';
import '../../exercise/exercise.dart';

class ProgramTemplateBundle {
  ProgramTemplateBundle({
    required this.programTemplate,
    required this.exerciseBundles,
  });

  ProgramTemplate programTemplate;
  List<ExerciseBundle> exerciseBundles;
}