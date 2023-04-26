
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc({
    required this.workoutDao,
    required this.workoutExerciseGroupDao,
    required this.workoutExerciseSetDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
  }) : super(const WorkoutState()) {
    on<WorkoutInitialize>(_initialize);
    on<WorkoutStart>(_start);
    on<WorkoutUpdate>(_update);
    on<WorkoutDelete>(_delete);
  }

  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  Future<void> _initialize(WorkoutInitialize event, emit) async {
    emit(state.copyWith(status: () => WorkoutStatus.loading));

    emit(state.copyWith(status: () => WorkoutStatus.none));

    workoutDao.getActiveWorkoutAsStream().listen((workout) => add(WorkoutUpdate(workout: workout)));
  }

  Future<void> _start(WorkoutStart event, Emitter<WorkoutState> emit) async {
    Workout convertedWorkout = Workout(
      name: event.template.name,
      isActive: true,
      timestamp: DateTime.now(),
    );

    int workoutId = await workoutDao.addWorkout(convertedWorkout);

    List<TemplateExerciseGroup> templateExerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(event.template.templateId!);

    for (var templateExerciseGroup in templateExerciseGroups) {
      int workoutExerciseGroupId = await workoutExerciseGroupDao.addWorkoutExerciseGroup(WorkoutExerciseGroup(
        restTimed: templateExerciseGroup.restTimed,
        barId: templateExerciseGroup.barId,
        exerciseId: templateExerciseGroup.exerciseId,
        workoutId: workoutId,
      ));

      List<TemplateExerciseSet> templateExerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(templateExerciseGroup.templateExerciseGroupId!);

      for(var templateExerciseSet in templateExerciseSets){
        workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet(
          workoutExerciseGroupId: workoutExerciseGroupId,
          workoutId: workoutId,
          option_1: templateExerciseSet.option1,
          option_2: templateExerciseSet.option2,
          checked: 0,
        ));
      }
    }
  }

  Future<void> _update(WorkoutUpdate event, Emitter<WorkoutState> emit) async {
    Workout? workout = event.workout;

    if(workout == null) {
      emit(state.copyWith(status: () => WorkoutStatus.none,));
      return;
    } else {
      emit(state.copyWith(
        status: () => WorkoutStatus.active,
        workout: () => workout,
      ));
    }
  }

  Future<void> _delete(WorkoutDelete event, Emitter<WorkoutState> emit) async {
    await workoutDao.deleteWorkout(event.workout);

    emit(state.copyWith(status: () => WorkoutStatus.none,));
  }
}