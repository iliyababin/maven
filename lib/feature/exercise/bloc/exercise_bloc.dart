import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/model/exercise.dart';
import '../dao/exercise_dao.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc({
    required this.exerciseDao,
  }) : super(const ExerciseState()) {
    exerciseDao.getExercisesAsStream().listen((event) => add(ExerciseStreamUpdateExercises(exercises: event)));

    on<ExerciseStreamUpdateExercises>(_exerciseStreamUpdateExercises);
    on<ExerciseInitialize>(_exerciseInitialize);
  }

  final ExerciseDao exerciseDao;


  Future<void> _exerciseInitialize(ExerciseInitialize event, emit) async {
    emit(state.copyWith(status: () => ExerciseStatus.loaded));
  }

  Future<void> _exerciseStreamUpdateExercises(ExerciseStreamUpdateExercises event, emit) async {
    emit(state.copyWith(exercises: () => event.exercises));
  }
}
