import '../../../../common/model/active_exercise_set.dart';

abstract class ActiveExerciseSetRepository {

  Future<int> addActiveExerciseSet(ActiveExerciseSet activeExerciseSet);

  Future<List<ActiveExerciseSet>> getActiveExerciseSets();

  Future<List<ActiveExerciseSet>> getActiveExerciseSetsByActiveExerciseGroupId(int activeExerciseGroupId);

  Future<int> updateActiveExerciseSet(ActiveExerciseSet activeExerciseSet);

  Future<int> deleteActiveExerciseSet(int activeExerciseSetId);

  Future<void> deleteActiveExerciseSetsByWorkoutId(int workoutId);
}