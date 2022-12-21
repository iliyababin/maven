import 'dart:async';

import 'package:maven/model/exercise_group.dart';
import 'package:maven/util/database_helper.dart';

class ExerciseGroupBloc {
  ExerciseGroupBloc() {
    getExerciseGroups();
  }

  final _exerciseGroupController = StreamController<List<ExerciseGroup>>.broadcast();

  get exerciseGroups => _exerciseGroupController.stream;

  dispose() {
    _exerciseGroupController.close();
  }

  void addExerciseGroup(ExerciseGroup exerciseGroup) {
    DatabaseHelper.instance.addExerciseGroup(exerciseGroup);
    getExerciseGroups();
  }

  void deleteExerciseGroup(int id) {
    DatabaseHelper.instance.deleteExerciseGroup(id);
    getExerciseGroups();
  }

  void getExerciseGroupsByWorkoutId(int workoutId) async {
    _exerciseGroupController.sink.add(await DatabaseHelper.instance.getExerciseGroupsByWorkoutId(workoutId));
  }

  void getExerciseGroups() async {
    _exerciseGroupController.sink.add(await DatabaseHelper.instance.getExerciseGroups());
  }
}
