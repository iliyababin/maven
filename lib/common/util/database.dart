import 'dart:async';

import 'package:Maven/common/util/date_time_converter.dart';
import 'package:Maven/feature/workout/template/dao/exercise_dao.dart';
import 'package:Maven/feature/workout/template/model/exercise.dart';
import 'package:Maven/feature/workout/template/model/template_exercise_group.dart';
import 'package:Maven/feature/workout/template/model/template_exercise_set.dart';
import 'package:Maven/feature/workout/workout/dao/workout_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../feature/workout/template/dao/template_dao.dart';
import '../../feature/workout/template/dao/template_exercise_group_dao.dart';
import '../../feature/workout/template/dao/template_exercise_set_dao.dart';
import '../../feature/workout/template/dao/template_folder_dao.dart';
import '../../feature/workout/template/model/template.dart';
import '../../feature/workout/template/model/template_folder.dart';
import '../../feature/workout/workout/dao/workout_exercise_group_dao.dart';
import '../../feature/workout/workout/dao/workout_exercise_set_dao.dart';
import '../../feature/workout/workout/model/workout.dart';
import '../model/workout_exercise_group.dart';
import '../model/workout_exercise_set.dart';

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
  ],
)
@TypeConverters([
  DateTimeConverter,
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

}