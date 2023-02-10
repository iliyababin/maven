import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../feature/workout/barbell_calculator/dao/plate_dao.dart';
import '../feature/workout/barbell_calculator/model/plate.dart';
import '../feature/workout/template/dao/exercise_dao.dart';
import '../feature/workout/template/dao/template_dao.dart';
import '../feature/workout/template/dao/template_exercise_group_dao.dart';
import '../feature/workout/template/dao/template_exercise_set_dao.dart';
import '../feature/workout/template/dao/template_folder_dao.dart';
import '../feature/workout/template/model/exercise.dart';
import '../feature/workout/template/model/template.dart';
import '../feature/workout/template/model/template_exercise_group.dart';
import '../feature/workout/template/model/template_exercise_set.dart';
import '../feature/workout/template/model/template_folder.dart';
import '../feature/workout/workout/dao/workout_dao.dart';
import '../feature/workout/workout/dao/workout_exercise_group_dao.dart';
import '../feature/workout/workout/dao/workout_exercise_set_dao.dart';
import '../feature/workout/workout/model/workout.dart';
import '../feature/workout/workout/model/workout_exercise_group.dart';
import '../feature/workout/workout/model/workout_exercise_set.dart';
import 'type_converter/color_convert.dart';
import 'type_converter/date_time_converter.dart';
import 'type_converter/exercise_type_converter.dart';

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
  ],
)
@TypeConverters([
  DateTimeConverter,
  ExerciseTypeConverter,
  ColorConverter,
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

}