import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/template/template.dart';

import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
import '../../../routine/service/service.dart';
import '../../model/workout.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc({
    required this.routineService,
    required this.databaseService,
  }) : super(const WorkoutState()) {
    on<WorkoutInitialize>(_initialize);
    on<WorkoutStart>(_start);
    on<WorkoutStateEmpty>(_empty);
    on<WorkoutFinish>(_finish);
    on<WorkoutDelete>(_delete);
  }

  final RoutineService routineService;
  final DatabaseService databaseService;

  Future<void> _initialize(WorkoutInitialize event, emit) async {
    Workout? workout = await routineService.getWorkout();

    emit(state.copyWith(
      status: workout == null ? WorkoutStatus.none : WorkoutStatus.active,
      workout: workout,
    ));
  }

  Future<void> _start(WorkoutStart event, Emitter<WorkoutState> emit) async {
    emit(state.copyWith(
      status: WorkoutStatus.loading,
    ));

    Workout? workout = await routineService.startTemplate(event.template);

    emit(state.copyWith(
      status: WorkoutStatus.active,
      workout: workout,
    ));
  }

  Future<void> _empty(WorkoutStateEmpty event, Emitter<WorkoutState> emit) async {
    emit(state.copyWith(
      status: WorkoutStatus.loading,
    ));

    Workout workout = await routineService.addWorkout(Routine(
      name: 'Empty Workout',
      note: '',
      timestamp: DateTime.now(),
      type: RoutineType.workout,
    ));

    emit(state.copyWith(
      status: WorkoutStatus.active,
      workout: workout,
    ));
  }

  Future<void> _finish(WorkoutFinish event, Emitter<WorkoutState> emit) async {
    await routineService.deleteRoutine(event.workout.routine);

    emit(state.copyWith(
      status: WorkoutStatus.none,
    ));
  }

  Future<void> _delete(WorkoutDelete event, Emitter<WorkoutState> emit) async {
    await routineService.deleteRoutine(state.workout!.routine);

    emit(state.copyWith(
      status: WorkoutStatus.none,
    ));
  }
}
