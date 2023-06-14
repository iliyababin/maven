import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/dao/exercise_dao.dart';
import '../../../database/dao/exercise_field_dao.dart';
import '../../../database/model/exercise.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc({
    required this.exerciseDao,
    required this.exerciseFieldDao,
  }) : super(const ExerciseState()) {
    on<ExerciseInitialize>(_exerciseInitialize);
  }

  final ExerciseDao exerciseDao;
  final ExerciseFieldDao exerciseFieldDao;

  Future<void> _exerciseInitialize(ExerciseInitialize event, emit) async {
    List<Exercise> exercises = await exerciseDao.getExercises();

    for (int i = 0; i < exercises.length; i++) {
      exercises[i] = exercises[i].copyWith(fields: await exerciseFieldDao.getExerciseFieldsByExerciseId(exercises[i].exerciseId!));
    }

    emit(state.copyWith(
      status: () => ExerciseStatus.loaded,
      exercises: () => exercises,
    ));
  }
}
