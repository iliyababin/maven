import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../feature/exercise/model/exercise_equipment.dart';
import 'converter/converter.dart';
import 'dao/dao.dart';
import 'model/model.dart';

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
    Plate,
    Bar,
    Program,
    Folder,
    TemplateTracker,
  ],
)
@TypeConverters([
  DateTimeConverter,
  ExerciseTypeConverter,
  ExerciseEquipmentConverter,
  ColorConverter,
  TimedConverter,
])
abstract class MavenDatabase extends FloorDatabase {
  ExerciseDao get exerciseDao;
  TemplateDao get templateDao;
  TemplateExerciseGroupDao get templateExerciseGroupDao;
  TemplateExerciseSetDao get templateExerciseSetDao;
  WorkoutDao get workoutDao;
  WorkoutExerciseGroupDao get workoutExerciseGroupDao;
  WorkoutExerciseSetDao get workoutExerciseSetDao;
  PlateDao get plateDao;
  BarDao get barDao;
  ProgramDao get programDao;
  FolderDao get folderDao;
  TemplateTrackerDao get templateTrackerDao;
}