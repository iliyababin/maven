import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/model/exercise_set.dart';
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
    await deleteDatabase('testy161.db');
    String path = join(documentsDirectory.path, 'testy161.db');

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


    // TODO: Generate table on app start
    //addTemplateFolder(TemplateFolder(name: "My Templates", expanded: 0));
  }
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
