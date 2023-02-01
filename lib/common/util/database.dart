import 'dart:async';

import 'package:Maven/common/dao/exercise_dao.dart';
import 'package:Maven/feature/workout/template/model/exercise.dart';
import 'package:Maven/feature/workout/template/model/template_exercise_group.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../feature/workout/template/dao/template_dao.dart';
import '../../feature/workout/template/dao/template_exercise_group_dao.dart';
import '../../feature/workout/template/dao/template_folder_dao.dart';
import '../../feature/workout/template/model/template.dart';
import '../../feature/workout/template/model/template_folder.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [
    Exercise,
    TemplateFolder,
    Template,
    TemplateExerciseGroup,
  ],
)
abstract class MavenDatabase extends FloorDatabase {

  ExerciseDao get exerciseDao;
  TemplateFolderDao get templateFolderDao;
  TemplateDao get templateDao;
  TemplateExerciseGroupDao get templateExerciseGroupDao;

}