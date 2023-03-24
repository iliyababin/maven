import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../feature/equipment/dao/bar_dao.dart';
import '../feature/equipment/dao/plate_dao.dart';
import '../feature/equipment/model/bar.dart';
import '../feature/equipment/model/plate.dart';
import '../feature/exercise/dao/exercise_dao.dart';
import '../feature/exercise/model/exercise.dart';
import '../feature/exercise/model/exercise_equipment.dart';
import '../feature/template/dao/template_dao.dart';
import '../feature/template/dao/template_exercise_group_dao.dart';
import '../feature/template/dao/template_exercise_set_dao.dart';
import '../feature/template/dao/template_folder_dao.dart';
import '../feature/template/model/template.dart';
import '../feature/template/model/template_exercise_group.dart';
import '../feature/template/model/template_exercise_set.dart';
import '../feature/template/model/template_folder.dart';
import '../feature/workout/dao/workout_dao.dart';
import '../feature/workout/dao/workout_exercise_group_dao.dart';
import '../feature/workout/dao/workout_exercise_set_dao.dart';
import '../feature/workout/model/workout.dart';
import '../feature/workout/model/workout_exercise_group.dart';
import '../feature/workout/model/workout_exercise_set.dart';
import 'type_converter/color_convert.dart';
import 'type_converter/date_time_converter.dart';
import 'type_converter/exercise_equipment_converter.dart';
import 'type_converter/exercise_type_converter.dart';
import 'type_converter/timed_converter.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [
    Exercise,
    TemplateFolder,
    Template,
    TemplateExerciseGroup,
    TemplateExerciseSet,
    Workout,
    WorkoutExerciseGroup,
    WorkoutExerciseSet,
    Plate,
    Bar,
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

  TemplateFolderDao get templateFolderDao;
  TemplateDao get templateDao;
  TemplateExerciseGroupDao get templateExerciseGroupDao;
  TemplateExerciseSetDao get templateExerciseSetDao;

  WorkoutDao get workoutDao;
  WorkoutExerciseGroupDao get workoutExerciseGroupDao;
  WorkoutExerciseSetDao get workoutExerciseSetDao;

  PlateDao get plateDao;
  BarDao get barDao;
}