import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/repository/workout_repository.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {

  final DBHelper _dbHelper;

  WorkoutRepositoryImpl(this._dbHelper);

  @override
  Future<int> addWorkout(Workout workout) async {
    final Database db = await _dbHelper.database;
    return await db.insert(_dbHelper.WORKOUT_TABLE, workout.toMap());
  }

  @override
  Future<Workout?> getWorkout(int workoutId) async {
    final Database db = await _dbHelper.database;
    final workout = await db.query(
      _dbHelper.WORKOUT_TABLE,
      where: 'workoutId = ?',
      whereArgs: [workoutId],
    );
    return workout.isNotEmpty ? Workout.fromMap(workout.first) : null;
  }

  @override
  Future<Workout?> getWorkoutAAA() async {
    final Database db = await _dbHelper.database;
    final workout = await db.query(
      _dbHelper.WORKOUT_TABLE,
      where: 'isPaused = 0',
    );
    return workout.isNotEmpty ? Workout.fromMap(workout.first) : null;
  }

  @override
  Future<List<Workout>> getWorkouts() async {
    final Database db = await _dbHelper.database;
    var workouts = await db.query(_dbHelper.WORKOUT_TABLE);
    List<Workout> workoutList = workouts.isNotEmpty
        ? workouts.map((c) => Workout.fromMap(c)).toList()
        : [];
    return workoutList;
  }

  @override
  Future<List<Workout>> getPausedWorkouts() async {
    final Database db = await _dbHelper.database;
    var workouts = await db.query(
      _dbHelper.WORKOUT_TABLE,
      where: 'isPaused = ?',
      whereArgs: [1],
    );
    List<Workout> workoutList = workouts.isNotEmpty
        ? workouts.map((c) => Workout.fromMap(c)).toList()
        : [];
    return workoutList;
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    final Database db = await _dbHelper.database;
    await db.update(
      _dbHelper.WORKOUT_TABLE,
      workout.toMap(),
      where: 'workoutId = ?',
      whereArgs: [workout.workoutId],
    );
  }

  @override
  Future<int> deleteWorkout(int workoutId) async {
    final Database db = await _dbHelper.database;
    return await db.delete(
      _dbHelper.WORKOUT_TABLE,
      where: 'workoutId = ?',
      whereArgs: [workoutId],
    );
  }

}