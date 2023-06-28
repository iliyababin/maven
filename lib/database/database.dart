import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'converter/converter.dart';
import 'dao/dao.dart';
import 'data/data.dart';
import 'enum/enum.dart';
import 'model/model.dart';

export 'converter/converter.dart';
export 'dao/dao.dart';
export 'data/data.dart';
export 'enum/enum.dart';
export 'model/model.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [
    Bar,
    Exercise,
    ExerciseField,
    Plate,
    Program,
    ProgramExerciseGroup,
    ProgramFolder,
    ProgramTemplate,
    Session,
    SessionExerciseGroup,
    SessionExerciseSet,
    SessionExerciseSetData,
    Template,
    TemplateExerciseGroup,
    TemplateExerciseSet,
    TemplateExerciseSetData,
    Setting,
    Workout,
    WorkoutExerciseGroup,
    WorkoutExerciseSet,
    WorkoutExerciseSetData,
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
  BarDao get barDao;
  ExerciseDao get exerciseDao;
  ExerciseFieldDao get exerciseFieldDao;
  PlateDao get plateDao;
  ProgramDao get programDao;
  ProgramExerciseGroupDao get programExerciseGroupDao;
  ProgramFolderDao get programFolderDao;
  ProgramTemplateDao get programTemplateDao;
  SettingDao get settingDao;
  SessionDao get sessionDao;
  SessionExerciseGroupDao get sessionExerciseGroupDao;
  SessionExerciseSetDao get sessionExerciseSetDao;
  SessionExerciseSetDataDao get sessionExerciseSetDataDao;
  TemplateDao get templateDao;
  TemplateExerciseGroupDao get templateExerciseGroupDao;
  TemplateExerciseSetDao get templateExerciseSetDao;
  TemplateExerciseSetDataDao get templateExerciseSetDataDao;
  WorkoutDao get workoutDao;
  WorkoutExerciseGroupDao get workoutExerciseGroupDao;
  WorkoutExerciseSetDao get workoutExerciseSetDao;
  WorkoutExerciseSetDataDao get workoutExerciseSetDataDao;

  static final Callback _callback = Callback(
    onCreate: (database, version) {
      database.rawInsert('INSERT INTO setting (id, language_code, country_code, theme_id) VALUES (1, "en", "US", 1)');
    },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );
  
  static Future<MavenDatabase> initialize() async {
    MavenDatabase db = await $FloorMavenDatabase
        .databaseBuilder('maven_db_37.db')
        .addCallback(_callback)
        .build();
    db.plateDao.addPlates(getDefaultPlates());
    db.barDao.addBars(getDefaultBars());
    db.exerciseDao.addExercises(getDefaultExercises());
    db.exerciseFieldDao.addExerciseFields(getDefaults());
    return db;
  }
}