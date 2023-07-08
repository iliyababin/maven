import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc({
    required this.exerciseDao,
    required this.exerciseFieldDao,
  }) : super(const ExerciseState()) {
    on<ExerciseInitialize>(_initialize);
    on<ExerciseUpdate>(_update);
  }

  final ExerciseDao exerciseDao;
  final ExerciseFieldDao exerciseFieldDao;

  Future<void> _initialize(ExerciseInitialize event, emit) async {
    emit(state.copyWith(
      status: ExerciseStatus.loaded,
      exercises: await _getExercises(),
    ));
  }

  Future<void> _update(ExerciseUpdate event, emit) async {
    emit(state.copyWith(
      status: ExerciseStatus.loading,
    ));

    await exerciseDao.updateExercise(event.exercise);

    emit(state.copyWith(
      status: ExerciseStatus.loaded,
      exercises: await _getExercises(),
    ));
  }

  Future<List<Exercise>> _getExercises() async {
    List<Exercise> exercises = await exerciseDao.getExercises();

    for (int i = 0; i < exercises.length; i++) {
      exercises[i] = exercises[i].copyWith(fields: await exerciseFieldDao.getExerciseFieldsByExerciseId(exercises[i].id!));
    }

    return exercises;
  }
}
