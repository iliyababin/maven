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
export 'service/service.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [
    Bar,
    Exercise,
    ExerciseField,
    BaseExerciseGroup,
    BaseExerciseSet,
    BaseExerciseSetData,
    Plate,
    Program,
    ProgramExerciseGroup,
    ProgramFolder,
    ProgramTemplate,
    Setting,
    Routine,
    BaseNote,
    WorkoutData,
    SessionData,
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
  ExerciseGroupDao get baseExerciseGroupDao;
  ExerciseSetDao get exerciseSetDao;
  ExerciseSetDataDao get exerciseSetDataDao;
  ExerciseFieldDao get exerciseFieldDao;
  PlateDao get plateDao;
  ProgramDao get programDao;
  ProgramExerciseGroupDao get programExerciseGroupDao;
  ProgramFolderDao get programFolderDao;
  ProgramTemplateDao get programTemplateDao;
  RoutineDao get routineDao;
  SettingDao get settingDao;
  NoteDao get noteDao;
  WorkoutDataDao get workoutDataDao;
  SessionDataDao get sessionDataDao;

  static final Callback _callback = Callback(
    onCreate: (database, version) {
      database.rawInsert("INSERT INTO setting (id, language_code, country_code, theme_id, username, description) VALUES (1, 'en', 'US', 1, 'John Doe', 'Weightlifter')");
    },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );
  
  static Future<MavenDatabase> initialize() async {
    MavenDatabase db = await $FloorMavenDatabase
        .databaseBuilder('maven_db_1.db')
        .addCallback(_callback)
        .build();
    db.plateDao.addPlates(getDefaultPlates());
    db.barDao.addBars(getDefaultBars());
    db.exerciseDao.addExercises(getDefaultExercises());
    db.exerciseFieldDao.addExerciseFields(getDefaults());
    return db;
  }
}