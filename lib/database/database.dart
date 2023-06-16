import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'converter/converter.dart';
import 'dao/dao.dart';
import 'dao/setting_dao.dart';
import 'data/data.dart';
import 'enum/enum.dart';
import 'model/model.dart';
import 'model/setting.dart';

export 'converter/converter.dart';
export 'dao/dao.dart';
export 'data/data.dart';
export 'enum/enum.dart';
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
    Session,
    SessionExerciseGroup,
    SessionExerciseSet,
    Plate,
    Bar,
    Program,
    Folder,
    TemplateTracker,
    Setting,
    ExerciseField,
    TemplateExerciseSetData,
  ],
)
@TypeConverters([
  DateTimeConverter,
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
  TemplateExerciseSetDataDao get templateExerciseSetDataDao;

  WorkoutDao get workoutDao;
  WorkoutExerciseGroupDao get workoutExerciseGroupDao;
  WorkoutExerciseSetDao get workoutExerciseSetDao;
  SessionDao get completeDao;
  SessionExerciseGroupDao get completeExerciseGroupDao;
  SessionExerciseSetDao get completeExerciseSetDao;

  PlateDao get plateDao;
  BarDao get barDao;
  ProgramDao get programDao;
  FolderDao get folderDao;
  TemplateTrackerDao get templateTrackerDao;
  SettingDao get settingDao;

  ExerciseFieldDao get exerciseFieldDao;

  static final Callback _callback = Callback(
    onCreate: (database, version) {
      database.rawInsert('INSERT INTO setting (id, language_code, country_code, theme_id) VALUES (1, "en", "US", 2)');
    },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );
  
  static Future<MavenDatabase> initialize() async {
    MavenDatabase db = await $FloorMavenDatabase
        .databaseBuilder('maven_db_106.db')
        .addCallback(_callback)
        .build();
    db.plateDao.addPlates(getDefaultPlates());
    db.barDao.addBars(getDefaultBars());
    db.exerciseDao.addExercises(getDefaultExercises());
    db.exerciseFieldDao.addExerciseFields(getDefaults());
    return db;
  }
}