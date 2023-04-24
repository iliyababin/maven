import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/model/timed.dart';
import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';
import '../../../exercise/model/exercise_bundle.dart';
import '../../../exercise/model/exercise_group.dart';
import '../../../exercise/model/exercise_set.dart';

part 'workout_detail_event.dart';
part 'workout_detail_state.dart';

class WorkoutDetailBloc extends Bloc<WorkoutDetailEvent, WorkoutDetailState> {
  WorkoutDetailBloc({
    required this.workoutDao,
    required this.workoutExerciseGroupDao,
    required this.workoutExerciseSetDao,
    required this.exerciseDao,
  }) : super(const WorkoutDetailState()) {
    on<WorkoutDetailInitialize>(_initialize);
    on<WorkoutDetailLoad>(_load);

    on<WorkoutDetailAdd>(_add);
    on<WorkoutDetailUpdate>(_update);
    on<WorkoutDetailDelete>(_delete);
  }

  final WorkoutDao workoutDao;
  final WorkoutExerciseGroupDao workoutExerciseGroupDao;
  final WorkoutExerciseSetDao workoutExerciseSetDao;
  final ExerciseDao exerciseDao;

  Future<void> _initialize(WorkoutDetailInitialize event, Emitter<WorkoutDetailState> emit) async {
    emit(state.copyWith(status: () => WorkoutDetailStatus.loaded));
  }

  Future<void> _load(WorkoutDetailLoad event, Emitter<WorkoutDetailState> emit) async {
    emit(state.copyWith(status: () => WorkoutDetailStatus.loading));

    Workout? workout = await workoutDao.getWorkout(event.workoutId);

    List<ExerciseBundle> exerciseBundles = [];

    List<WorkoutExerciseGroup> workoutExerciseGroups = await workoutExerciseGroupDao.getWorkoutExerciseGroupsByWorkoutId(event.workoutId);

    for(WorkoutExerciseGroup workoutExerciseGroup in workoutExerciseGroups) {
      Exercise? exercise = await exerciseDao.getExercise(workoutExerciseGroup.exerciseId);
      List<WorkoutExerciseSet> workoutExerciseSets = await workoutExerciseSetDao.getWorkoutExerciseSetsByWorkoutExerciseGroupId(workoutExerciseGroup.workoutExerciseGroupId!);

      exerciseBundles.add(ExerciseBundle(
        exercise: exercise!,
        exerciseGroup: workoutExerciseGroup.toExerciseGroup(),
        exerciseSets: workoutExerciseSets.map((workoutExerciseSet) => workoutExerciseSet.toExerciseSet()).toList(),
        barId: workoutExerciseGroup.barId
      ));
    }

    emit(state.copyWith(
      status: () => WorkoutDetailStatus.loaded,
      workout: () => workout!,
      exerciseBundles: () => exerciseBundles,
    ));
  }

  Future<void> _add(WorkoutDetailAdd event, Emitter<WorkoutDetailState> emit) async {
    if(event.exercise != null) {
      Exercise exercise = event.exercise!;

      await workoutExerciseGroupDao.addWorkoutExerciseGroup(WorkoutExerciseGroup(
        restTimed: Timed(hour: 0, minute: 0, second: 0),
        barId: exercise.barId,
        exerciseId: exercise.exerciseId,
        workoutId: state.workout!.workoutId!,
      ));

      add(WorkoutDetailLoad(workoutId: state.workout!.workoutId!));
    } else if (event.exerciseSet != null) {
      ExerciseSet exerciseSet = event.exerciseSet!;

      await workoutExerciseSetDao.addWorkoutExerciseSet(WorkoutExerciseSet(
        option_1: exerciseSet.option1,
        option_2: exerciseSet.option2,
        checked: exerciseSet.checked ?? 0,
        workoutExerciseGroupId: exerciseSet.exerciseGroupId,
        workoutId: state.workout!.workoutId!,
      ));

    } else {

    }
  }

  Future<void> _update(WorkoutDetailUpdate event, Emitter<WorkoutDetailState> emit) async {
    
  }

  FutureOr<void> _delete(WorkoutDetailDelete event, Emitter<WorkoutDetailState> emit) async {
    if (event.exerciseGroup != null) {
      WorkoutExerciseGroup? workoutExerciseGroup = await workoutExerciseGroupDao.getWorkoutExerciseGroup(event.exerciseGroup!.exerciseGroupId);
      await workoutExerciseGroupDao.deleteWorkoutExerciseGroup(workoutExerciseGroup!);
    } else if (event.exerciseSet != null) {
      WorkoutExerciseSet? workoutExerciseSet = await workoutExerciseSetDao.getWorkoutExerciseSet(event.exerciseSet!.exerciseSetId);
      await workoutExerciseSetDao.deleteWorkoutExerciseSet(workoutExerciseSet!);
    } else {

    }
  }
}


