import '../../../../common/model/exercise_group.dart';

abstract class ExerciseGroupRepository {

  Future<int> addExerciseGroup(ExerciseGroup exerciseGroup);
}