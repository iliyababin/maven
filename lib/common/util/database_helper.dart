import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/common/model/exercise_group.dart';
import 'package:Maven/common/model/exercise_set.dart';
import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

///
/// Creates, manages, and performs CRUD operations on database. Stored on users system.
///
class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    await deleteDatabase('testy158.db');
    String path = join(documentsDirectory.path, 'testy158.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  ///
  /// Tables
  ///
  final String TEMPLATE_TABLE = 'template';
  final String TEMPLATE_FOLDER_TABLE = 'templateFolder';

  final String EXERCISE_GROUP_TABLE = 'exerciseGroup';
  final String EXERCISE_SET_TABLE = 'exerciseSet';

  final String WORKOUT_TABLE = 'workout';

  Future<List<Exercise>> _loadExerciseJson() async {
    String jsonString = await rootBundle.loadString('assets/exercises.json');
    List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    return jsonList.map((json) => Exercise.fromMap(json)).toList();
  }

  Future _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE exercise (
        exerciseId INTEGER PRIMARY KEY,
        name TEXT,
        muscle TEXT,
        picture TEXT
      );
    ''');
    
    await db.execute('''
      CREATE TABLE templateFolder (
        templateFolderId INTEGER PRIMARY KEY,
        name TEXT,
        expanded INTEGER,
        sortOrder INTEGER
      );
    ''');
    await db.execute('''
      CREATE TABLE template (
        templateId INTEGER PRIMARY KEY,
        name TEXT,
        sortOrder INTEGER,
        templateFolderId INTEGER,
        FOREIGN KEY (templateFolderId) REFERENCES templateFolder(templateFolderId)
      );
    ''');

    await db.execute('''
      CREATE TABLE exerciseGroup (
        exerciseGroupId INTEGER PRIMARY KEY,
        exerciseId INTEGER,
        templateId INTEGER,
        FOREIGN KEY (exerciseId) REFERENCES exercise(exerciseId),
        FOREIGN KEY (templateId) REFERENCES template(templateId)
      );
    ''');
    await db.execute('''
      CREATE TABLE exerciseSet (
        exerciseSetId INTEGER PRIMARY KEY,
        weight INTEGER,
        reps INTEGER,
        exerciseGroupId INTEGER,
        templateId INTEGER,
        FOREIGN KEY (exerciseGroupId) REFERENCES exerciseGroup(exerciseGroupId),
        FOREIGN KEY (templateId) REFERENCES template(templateId)
      );
    ''');

    await db.execute('''
      CREATE TABLE workout (
        workoutId INTEGER PRIMARY KEY,
        name TEXT,
        isPaused INTEGER,
        datetime TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE activeExerciseGroup (
        activeExerciseGroupId INTEGER PRIMARY KEY,
        exerciseId INTEGER,
        workoutId INTEGER,
        FOREIGN KEY (exerciseId) REFERENCES exercise(exerciseId),
        FOREIGN KEY (workoutId) REFERENCES workout(workoutId)
      );
    ''');
    await db.execute('''
      CREATE TABLE activeExerciseSet (
        activeExerciseSetId INTEGER PRIMARY KEY,
        weight INTEGER,
        reps INTEGER,
        checked INTEGER,
        activeExerciseGroupId INTEGER,
        workoutId INTEGER,
        FOREIGN KEY (activeExerciseGroupId) REFERENCES activeExerciseGroup(activeExerciseGroupId),
        FOREIGN KEY (workoutId) REFERENCES workout(workoutId)
      );
    ''');


    List<Exercise> exercises = await _loadExerciseJson();
    for (var exercise in exercises) {
      await db.execute(
        'INSERT INTO exercise (exerciseId, name, muscle, picture) VALUES (?, ?, ?, ?)',
        [exercise.exerciseId, exercise.name, exercise.muscle, exercise.picture],
      );
    }

    // TODO: Generate table on app start
    //addTemplateFolder(TemplateFolder(name: "My Templates", expanded: 0));
  }

  ///
  /// exercise
  ///

  Future<Exercise?> getExercise(int exerciseId) async {
    final db = await instance.database;
    final exercise = await db
        .query('exercise', where: 'exerciseId = ?', whereArgs: [exerciseId]);
    return exercise.isNotEmpty ? Exercise.fromMap(exercise.first) : null;
  }

  Future<List<Exercise>> getExercises() async {
    Database db = await instance.database;
    var exercises = await db.query('exercise');
    List<Exercise> exerciseList = exercises.isNotEmpty
        ? exercises.map((c) => Exercise.fromMap(c)).toList()
        : [];
    return exerciseList;
  }




  Future<int> updateTemplateFolder(TemplateFolder templateFolder) async {
    final Database db = await instance.database;
    return await db.update(
      'templateFolder',
      templateFolder.toMap(),
      where: 'templateFolderId = ?',
      whereArgs: [templateFolder.templateFolderId],
    );
  }

  Future<List<Template>> getTemplateFoldersByTemplateFolderId(int templateFolderId) async {
    final Database db = await instance.database;
    var templates = await db.query(
      'template',
      where: 'templateFolderId = ?',
      whereArgs: [templateFolderId],
    );
    List<Template> templateList = templates.isNotEmpty
        ? templates.map((c) => Template.fromMap(c)).toList()
        : [];
    return templateList;
  }

  Future<int> deleteTemplate(int id) async {
    final Database db = await instance.database;
    return await db.delete('template', where: 'templateId = ?', whereArgs: [id]);
  }

  ///
  /// exerciseGroup
  ///
  Future<int> addExerciseGroup(ExerciseGroup exerciseGroup) async {
    Database db = await instance.database;
    return await db.insert('exerciseGroup', exerciseGroup.toMap());
  }

  Future<List<ExerciseGroup>> getExerciseGroups() async {
    final db = await instance.database;
    final exerciseGroups = await db.query('exerciseGroup');
    return exerciseGroups.isNotEmpty
        ? exerciseGroups.map((c) => ExerciseGroup.fromMap(c)).toList()
        : [];
  }

  Future<List<ExerciseGroup>> getExerciseGroupsByTemplateId(int templateId) async {
    final db = await instance.database;
    var exerciseGroups = await db.query(
      'exerciseGroup',
      where: 'templateId = ?',
      whereArgs: [templateId],
    );
    List<ExerciseGroup> exerciseGroupList = exerciseGroups.isNotEmpty
        ? exerciseGroups.map((c) => ExerciseGroup.fromMap(c)).toList()
        : [];
    return exerciseGroupList;
  }

  Future<int> deleteExerciseGroup(int id) async {
    final db = await instance.database;
    return await db
        .delete('exerciseGroup', where: 'exerciseGroupId = ?', whereArgs: [id]);
  }

  Future<void> deleteExerciseGroupsByTemplateId(int templateId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> exerciseGroups = await db
        .query('exerciseGroup', where: 'templateId = ?', whereArgs: [templateId]);
    for (var exerciseGroup in exerciseGroups) {
      await deleteExerciseGroup(exerciseGroup['exerciseGroupId']);
    }
  }

  ///
  /// exerciseSet
  ///

  Future<List<ExerciseSet>> getExerciseSets() async {
    final db = await instance.database;
    final exerciseSets = await db.query('exerciseSet');
    return exerciseSets.isNotEmpty
        ? exerciseSets.map((c) => ExerciseSet.fromMap(c)).toList()
        : [];
  }

  Future<List<ExerciseSet>> getExerciseSetsByExerciseGroupId(int exerciseGroupId) async {
    final db = await instance.database;
    var exerciseSets = await db.query(
      'exerciseSet',
      where: 'exerciseGroupId = ?',
      whereArgs: [exerciseGroupId],
    );
    List<ExerciseSet> exerciseSetList = exerciseSets.isNotEmpty
        ? exerciseSets.map((c) => ExerciseSet.fromMap(c)).toList()
        : [];
    return exerciseSetList;
  }

  Future<void> deleteExerciseSetsByTemplateId(int templateId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> exerciseSets = await db
        .query('exerciseSet', where: 'templateId = ?', whereArgs: [templateId]);
    for (var exerciseSet in exerciseSets) {
      await deleteExerciseSet(exerciseSet['exerciseSetId']);
    }
  }

  Future<int> deleteExerciseSet(int exerciseSetId) async {
    final db = await instance.database;
    return await db.delete('exerciseSet',
        where: 'exerciseSetId = ?', whereArgs: [exerciseSetId]);
  }



  ///
  /// activeExerciseGroup
  ///
  Future<int> addActiveExerciseGroup(ActiveExerciseGroup activeExerciseGroup) async {
    final db = await instance.database;
    return await db.insert('activeExerciseGroup', activeExerciseGroup.toMap());
  }

  Future<List<ActiveExerciseGroup>> getActiveExerciseGroups() async {
    Database db = await instance.database;
    var activeExerciseGroups = await db.query('activeExerciseGroup');
    List<ActiveExerciseGroup> activeExerciseGroupList = activeExerciseGroups.isNotEmpty
        ? activeExerciseGroups.map((c) => ActiveExerciseGroup.fromMap(c)).toList()
        : [];
    return activeExerciseGroupList;
  }

  Future<List<ActiveExerciseGroup>> getActiveExerciseGroupsByWorkoutId(int workoutId) async {
    final db = await instance.database;
    var activeExerciseGroups = await db.query(
      'activeExerciseGroup',
      where: 'workoutId = ?',
      whereArgs: [workoutId],
    );
    List<ActiveExerciseGroup> activeExerciseGroupList = activeExerciseGroups.isNotEmpty
        ? activeExerciseGroups.map((c) => ActiveExerciseGroup.fromMap(c)).toList()
        : [];
    return activeExerciseGroupList;
  }

  Future<int> deleteActiveExerciseGroup(int activeExerciseGroupId) async {
    final db = await instance.database;
    return await db.delete('activeExerciseGroup',
        where: 'activeExerciseGroupId = ?', whereArgs: [activeExerciseGroupId]);
  }

  Future<void> deleteActiveExerciseGroupsByWorkoutId(int workoutId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> activeExerciseGroups = await db
        .query('activeExerciseGroup', where: 'workoutId = ?', whereArgs: [workoutId]);
    for (var activeExerciseGroup in activeExerciseGroups) {
      await deleteActiveExerciseGroup(activeExerciseGroup['activeExerciseGroupId']);
    }
  }

  ///
  /// activeExerciseSet
  ///
  Future<int> addActiveExerciseSet(ActiveExerciseSet activeExerciseSet) async {
    final db = await instance.database;
    return await db.insert('activeExerciseSet', activeExerciseSet.toMap());
  }

  Future<List<ActiveExerciseSet>> getActiveExerciseSets() async {
    final db = await instance.database;
    var activeExerciseSets = await db.query('activeExerciseSet');
    List<ActiveExerciseSet> activeExerciseSetList = activeExerciseSets.isNotEmpty
        ? activeExerciseSets.map((c) => ActiveExerciseSet.fromMap(c)).toList()
        : [];
    return activeExerciseSetList;
  }

  Future<List<ActiveExerciseSet>> getActiveExerciseSetsByActiveExerciseGroupId(int activeExerciseGroupId) async {
    final db = await instance.database;
    var activeExerciseSets = await db.query(
      'activeExerciseSet',
      where: 'activeExerciseGroupId = ?',
      whereArgs: [activeExerciseGroupId],
    );
    List<ActiveExerciseSet> activeExerciseSetsList = activeExerciseSets.isNotEmpty
        ? activeExerciseSets.map((c) => ActiveExerciseSet.fromMap(c)).toList()
        : [];
    return activeExerciseSetsList;
  }

  Future<int> updateActiveExerciseSet(ActiveExerciseSet activeExerciseSet) async {
    final Database db = await instance.database;
    return await db.update(
      'activeExerciseSet',
      activeExerciseSet.toMap(),
      where: 'activeExerciseSetId = ?',
      whereArgs: [activeExerciseSet.activeExerciseSetId],
    );
  }

  Future<int> deleteActiveExerciseSet(int activeExerciseSetId) async {
    final db = await instance.database;
    return await db.delete('activeExerciseSet',
        where: 'activeExerciseSetId = ?', whereArgs: [activeExerciseSetId]);
  }

  Future<void> deleteActiveExerciseSetsByWorkoutId(int workoutId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> activeExerciseSets = await db
        .query('activeExerciseSet', where: 'workoutId = ?', whereArgs: [workoutId]);
    log(activeExerciseSets.length.toString());
    for (var activeExerciseSet in activeExerciseSets) {
      await deleteActiveExerciseSet(activeExerciseSet['activeExerciseSetId']);
    }
  }

  ///
  /// other
  ///


}
