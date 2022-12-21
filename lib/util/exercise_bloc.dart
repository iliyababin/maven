import 'dart:async';

import 'package:maven/common/model/exercise.dart';
import 'package:maven/util/database_helper.dart';

class ExerciseBloc {

  ExerciseBloc(){
    getExercises();
  }

  final _exerciseController = StreamController<List<Exercise>>.broadcast();

  get exercises => _exerciseController.stream;

  dispose(){
    _exerciseController.close();
  }

  Future<Exercise?> getExercise(int exerciseId) async {
    return DatabaseHelper.instance.getExercise(exerciseId);
  }

  void getExercises() async {
    _exerciseController.sink.add(await DatabaseHelper.instance.getExercises());
  }
}