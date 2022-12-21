import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maven/common/model/exercise.dart';
import 'package:maven/model/workout.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../model/exercise_group.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    await deleteDatabase('testy106.db');
    String path = join(documentsDirectory.path, 'testy106.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<List<Exercise>> _loadExerciseJson() async {
    String jsonString = await rootBundle.loadString('assets/exercises.json');
    List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    return jsonList.map((json) => Exercise.fromMap(json)).toList();
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE exercise (exerciseId INTEGER PRIMARY KEY, name TEXT, muscle TEXT, picture TEXT);');
    await db.execute('CREATE TABLE workout (workoutId INTEGER PRIMARY KEY, name TEXT);');
    await db.execute('CREATE TABLE exerciseGroup (exerciseGroupId INTEGER PRIMARY KEY, exerciseId INTEGER, workoutId INTEGER, FOREIGN KEY (exerciseId) REFERENCES exercise(exerciseId), FOREIGN KEY (workoutId) REFERENCES workout(workoutId));');



    List<Exercise> exercises = await _loadExerciseJson();
    for (var exercise in exercises) {
      await db.execute('INSERT INTO exercise (exerciseId, name, muscle, picture) VALUES (?, ?, ?, ?)',
        [exercise.exerciseId, exercise.name, exercise.muscle, exercise.picture],
      );
    }
  }


  // Workout Methods
  Future<int> addWorkout(Workout workout) async {
    Database db = await instance.database;
    return await db.insert('workout', workout.toMap());
  }

  Future<int> deleteWorkout(int id) async {
    final db = await instance.database;
    return await db.delete('workout', where: 'workoutId = ?', whereArgs: [id]);
  }

  Future<int> updateWorkout(Workout workout) async {
    final db = await instance.database;
    return await db.update(
      'workout',
      workout.toMap(),
      where: 'workoutId = ?',
      whereArgs: [workout.workoutId],
    );
  }

  Future<List<Workout>> getWorkouts() async {
    Database db = await instance.database;
    var workouts = await db.query('workout', orderBy: 'name');
    List<Workout> workoutList = workouts.isNotEmpty ? workouts.map((c) => Workout.fromMap(c)).toList() : [];
    return workoutList;
  }


  // Exercise Methods
  Future<Exercise?> getExercise(int exerciseId) async {
    final db = await instance.database;
    final exercise = await db.query('exercise', where: 'exerciseId = ?', whereArgs: [exerciseId]);
    return exercise.isNotEmpty ? Exercise.fromMap(exercise.first) : null;
  }

  Future<List<Exercise>> getExercises() async {
    Database db = await instance.database;
    var exercises = await db.query('exercise');
    List<Exercise> exerciseList = exercises.isNotEmpty ? exercises.map((c) => Exercise.fromMap(c)).toList() : [];
    return exerciseList;
  }


  //ExerciseGroup Methods
  Future<int> addExerciseGroup(ExerciseGroup exerciseGroup) async {
    Database db = await instance.database;
    return await db.insert('exerciseGroup', exerciseGroup.toMap());
  }


  Future<List<ExerciseGroup>> getExerciseGroups() async {
    final db = await instance.database;
    final exerciseGroups = await db.query('exerciseGroup');
    return exerciseGroups.isNotEmpty ? exerciseGroups.map((c) => ExerciseGroup.fromMap(c)).toList() : [];
  }

  Future<List<ExerciseGroup>> getExerciseGroupsByWorkoutId(int workoutId) async {
    final db = await instance.database;
    var exerciseGroups = await db.query(
      'exerciseGroup',
      where: 'workoutId = ?',
      whereArgs: [workoutId],
    );
    List<ExerciseGroup> exerciseGroupList = exerciseGroups.isNotEmpty ? exerciseGroups.map((c) => ExerciseGroup.fromMap(c)).toList() : [];
    return exerciseGroupList;
  }

  Future<int> deleteExerciseGroup(int id) async {
    final db = await instance.database;
    return await db.delete('exerciseGroup', where: 'exerciseGroupId = ?', whereArgs: [id]);
  }

  Future<Workout?> getWorkout(int workoutId) async {
    final db = await instance.database;
    final workout = await db.query('workout', where: 'workoutId = ?', whereArgs: [workoutId]);
    return workout.isNotEmpty ? Workout.fromMap(workout.first) : null;
  }
}
