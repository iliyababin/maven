import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'converter/converter.dart';
import 'data/data.dart';
import 'enum/enum.dart';
import 'table/table.dart';

export 'converter/converter.dart';
export 'data/data.dart';
export 'enum/enum.dart';
export 'service/service.dart';
export 'table/table.dart';

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
    BaseSetting,
    Routine,
    BaseNote,
    WorkoutData,
    SessionData,
    TemplateData,
    User,
    Import,
  ],
)
@TypeConverters([
  DateTimeConverter,
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
  TemplateDataDao get templateDataDao;
  UserDao get userDao;
  ImportDao get importDao;

  static bool _isFirstTime = false;

  static final Callback _callback = Callback(
    onCreate: (database, version) {
      _isFirstTime = true;
    },
    onOpen: (database) {},
    onUpgrade: (database, startVersion, endVersion) {},
  );
  
  static Future<MavenDatabase> initialize() async {
    MavenDatabase db = await $FloorMavenDatabase
        .databaseBuilder('maven_db_1.db')
        .addCallback(_callback)
        .build();
    if (_isFirstTime) {
      db.plateDao.addPlates(getDefaultPlates());
      db.barDao.addBars(getDefaultBars());
      for (Exercise exercise in getDefaultExercises()){
        int exerciseId = await db.exerciseDao.add(exercise);
        for (ExerciseField field in exercise.fields){
          db.exerciseFieldDao.add(field.copyWith(
            exerciseId: exerciseId,
          ));
        }
      }
    }
    return db;
  }
}