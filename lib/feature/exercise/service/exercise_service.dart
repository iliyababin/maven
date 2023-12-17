import 'package:maven/database/database.dart';

/// A service class for managing exercises and their fields in the database.
class ExerciseService {
  final ExerciseDao exerciseDao;
  final ExerciseFieldDao exerciseFieldDao;

  ExerciseService({
    required this.exerciseDao,
    required this.exerciseFieldDao,
  });

  /// Adds a new exercise with fields to the database.
  ///
  /// Throws [Exception] if the provided exercise already has a non-null ID.
  Future<Exercise> add(Exercise exercise) async {
    if (exercise.id != null) {
      throw Exception('Cannot add an exercise that already has an id');
    }

    int exerciseId = await exerciseDao.add(exercise);

    for (ExerciseField field in exercise.fields) {
      await exerciseFieldDao.add(ExerciseField(
        exerciseId: exerciseId,
        type: field.type,
      ));
    }

    return get(exerciseId);
  }

  /// Get an exercise with fields from the database.
  ///
  /// Throws [Exception] if the provided ID does not exist.
  Future<Exercise> get(int exerciseId) async {
    Exercise? exercise = await exerciseDao.getExercise(exerciseId);

    if (exercise == null) {
      throw Exception('Exercise does not exist');
    }

    List<ExerciseField> fields =
        await exerciseFieldDao.getByExerciseId(exerciseId);
    return exercise.copyWith(fields: fields);
  }

  /// Get all exercises with fields from the database.
  Future<List<Exercise>> getAll() async {
    List<Exercise> exercises = await exerciseDao.getExercises();
    for (int i = 0; i < exercises.length; i++) {
      exercises[i] = await get(exercises[i].id!);
    }
    return exercises;
  }

  /// Update a exercise with fields in the database.
  ///
  /// Throws [Exception] if the provided exercise has a null ID.
  /// Throws [Exception] if the provided exercise does not exist.
  ///
  /// Note: This method will only add new fields to the database
  Future<Exercise> update(Exercise exercise) async {
    if (exercise.id == null) {
      throw Exception('Cannot update an exercise that does not have an id');
    }

    int rowsChanged = await exerciseDao.updateExercise(exercise);

    if (rowsChanged == 0) {
      throw Exception('No rows changed, exercise does not exist');
    }

    for (ExerciseField field in exercise.fields) {
      if (field.id == null) {
        await exerciseFieldDao.add(field);
      }
    }

    return get(exercise.id!);
  }
}
