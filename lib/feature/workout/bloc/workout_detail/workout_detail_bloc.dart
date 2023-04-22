import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';
import '../../../exercise/model/exercise_bundle.dart';

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
    on<WorkoutDetailUpdate>(_update);
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

  Future<void> _update(WorkoutDetailUpdate event, Emitter<WorkoutDetailState> emit) async {
    List<ExerciseBundle> eventExerciseBundles = event.exerciseBundles;
    List<ExerciseBundle> stateExerciseBundles = state.exerciseBundles;

    for (ExerciseBundle exerciseBundle in eventExerciseBundles) {
      if (stateExerciseBundles.contains(exerciseBundle)) {
        print(exerciseBundle);

      }
    }
  }
}


