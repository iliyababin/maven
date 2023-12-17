import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/database.dart';
import '../../exercise.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc({
    required this.exerciseService,
  }) : super(const ExerciseState()) {
    on<ExerciseInitialize>(_initialize);
    on<ExerciseAdd>(_add);
    on<ExerciseUpdate>(_update);
  }

  final ExerciseService exerciseService;

  Future<void> _initialize(ExerciseInitialize event, emit) async {
    emit(state.copyWith(
      status: ExerciseStatus.loaded,
      exercises: await exerciseService.getAll(),
    ));
  }

  Future<void> _add(ExerciseAdd event, emit) async {
    emit(state.copyWith(
      status: ExerciseStatus.loading,
    ));

    Exercise exercise = await exerciseService.add(event.exercise);

    emit(state.copyWith(
      status: ExerciseStatus.loaded,
      exercises: [...state.exercises, exercise],
    ));
  }

  Future<void> _update(ExerciseUpdate event, emit) async {
    emit(state.copyWith(
      status: ExerciseStatus.loading,
    ));

    Exercise exercise = await exerciseService.update(event.exercise);

    emit(state.copyWith(
      status: ExerciseStatus.loaded,
      exercises: [
        for (Exercise e in state.exercises)
          if (e.id == exercise.id) exercise else e],
    ));
  }
}
