import '../../../../common/model/active_exercise_group.dart';

abstract class ActiveExerciseGroupRepository {

  Future<int> addActiveExerciseGroup(ActiveExerciseGroup activeExerciseGroup);

  Future<List<ActiveExerciseGroup>> getActiveExerciseGroups();

  Future<List<ActiveExerciseGroup>> getActiveExerciseGroupsByWorkoutId(int workoutId);

  Future<int> deleteActiveExerciseGroup(int activeExerciseGroupId);

  Future<void> deleteActiveExerciseGroupsByWorkoutId(int workoutId);
}