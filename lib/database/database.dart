import 'dart:async';

import 'package:floor/floor.dart';
import 'package:maven/database/converter/duration_converter.dart';
import 'package:maven/database/converter/set_type_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../feature/exercise/model/muscle.dart';
import '../feature/exercise/model/muscle_group.dart';
import 'converter/converter.dart';
import 'dao/dao.dart';
import 'dao/setting_dao.dart';
import 'model/model.dart';
import 'model/setting.dart';

export 'dao/dao.dart';
export 'model/model.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [
    Exercise,
    Template,
    TemplateExerciseGroup,
    TemplateExerciseSet,
    Workout,
    WorkoutExerciseGroup,
    WorkoutExerciseSet,
    Complete,
    CompleteExerciseGroup,
    CompleteExerciseSet,
    Plate,
    Bar,
    Program,
    Folder,
    TemplateTracker,
    Setting,
  ],
)
@TypeConverters([
  DateTimeConverter,
  ExerciseTypeConverter,
  EquipmentConverter,
  ColorConverter,
  TimedConverter,
  SetTypeConverter,
  DurationConverter,
])
abstract class MavenDatabase extends FloorDatabase {
  ExerciseDao get exerciseDao;
  TemplateDao get templateDao;
  TemplateExerciseGroupDao get templateExerciseGroupDao;
  TemplateExerciseSetDao get templateExerciseSetDao;
  WorkoutDao get workoutDao;
  WorkoutExerciseGroupDao get workoutExerciseGroupDao;
  WorkoutExerciseSetDao get workoutExerciseSetDao;
  CompleteDao get completeDao;
  CompleteExerciseGroupDao get completeExerciseGroupDao;
  CompleteExerciseSetDao get completeExerciseSetDao;

  PlateDao get plateDao;
  BarDao get barDao;
  ProgramDao get programDao;
  FolderDao get folderDao;
  TemplateTrackerDao get templateTrackerDao;
  SettingDao get settingDao;

  static final Callback _callback = Callback(
    onCreate: (database, version) {
      database.rawInsert('INSERT INTO setting (id, language_code, country_code, theme_id) VALUES (1, "en", "US", 2)');
    },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );

  static Future<MavenDatabase> initialize() async {
    MavenDatabase db = await $FloorMavenDatabase
        .databaseBuilder('maven_db_70.db')
        .addCallback(_callback)
        .build();
    db.plateDao.addPlates(getDefaultPlates());
    db.barDao.addBars(getDefaultBars());
    db.exerciseDao.addExercises(getDefaultExercises());
    return db;
  }
}