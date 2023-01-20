
import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/model/exercise.dart';
import '../../../../common/model/template.dart';
import '../../../../common/model/workout.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(const WorkoutState()) {
    on<InitializeWorkoutBloc>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      Workout? workout = await DBHelper.instance.getWorkoutAAA();

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      if(workout == null){
        emit(state.copyWith(
          status: () => WorkoutStatus.none,
          pausedWorkouts: () => pausedWorkouts

        ));
      } else {
          List<ActiveExerciseGroup> activeExerciseGroups = await DBHelper.instance.getActiveExerciseGroupsByWorkoutId(workout.workoutId!);
          List<ActiveExerciseSet> activeExerciseSets = [];

          for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
            List<ActiveExerciseSet> activeExerciseBunch = await DBHelper.instance
                .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
            activeExerciseSets.addAll(activeExerciseBunch);
          }

        emit(state.copyWith(
          status: () => WorkoutStatus.active,
          pausedWorkouts: () => pausedWorkouts,
          workout: () => workout,
          activeExerciseGroups: () => activeExerciseGroups,
          activeExerciseSets: () => activeExerciseSets,
        ));
      }
    });

    on<ConvertTemplateToWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      int workoutId = await DBHelper.instance.generateWorkoutFromTemplate(event.template.templateId!);
      Workout? workout = await DBHelper.instance.getWorkout(workoutId);
      List<ActiveExerciseGroup> activeExerciseGroups = await DBHelper.instance.getActiveExerciseGroupsByWorkoutId(workout!.workoutId!);

      List<ActiveExerciseSet> activeExerciseSets = [];

      for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
        List<ActiveExerciseSet> activeExerciseBunch = await DBHelper.instance
            .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
        activeExerciseSets.addAll(activeExerciseBunch);
      }

      emit(state.copyWith(
        workout: () => workout,
        status: () => WorkoutStatus.active,
        activeExerciseGroups: () => activeExerciseGroups,
        activeExerciseSets: () => activeExerciseSets,
      ));
    });

    on<PauseWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      if(state.workout == null) return;

      Workout? workout = await DBHelper.instance.getWorkout(state.workout?.workoutId ?? 0);
      workout?.isPaused = 1;

      await DBHelper.instance.updateWorkout(workout!);

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts
      ));
    });

    on<UnpauseWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      Workout workout = event.workout;
      workout.isPaused = 0;

      await DBHelper.instance.updateWorkout(workout);

      Workout? updatedWorkout = await DBHelper.instance.getWorkoutAAA();

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      emit(state.copyWith(
          workout: () => updatedWorkout!,
          status: () => WorkoutStatus.active,
          pausedWorkouts: () => pausedWorkouts
      ));
    });

    on<DeleteActiveWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      int workoutId = state.workout?.workoutId! ?? -1;
      DBHelper.instance.deleteWorkout(workoutId);
      DBHelper.instance.deleteActiveExerciseGroupsByWorkoutId(workoutId);
      DBHelper.instance.deleteActiveExerciseSetsByWorkoutId(workoutId);

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts,
        activeExerciseGroups: () => [],
        activeExerciseSets: () => [],
      ));
    });

    on<AddExercise>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      DBHelper.instance.addActiveExerciseGroup(
        ActiveExerciseGroup.exerciseToActiveExerciseGroup(
          event.exercise.exerciseId,
          state.workout!.workoutId!
        )
      );

      List<ActiveExerciseGroup> activeExerciseGroups = await DBHelper.instance.getActiveExerciseGroupsByWorkoutId(state.workout!.workoutId!);

      emit(state.copyWith(
        status: () => WorkoutStatus.active,
        activeExerciseGroups: () => activeExerciseGroups
      ));
    });

    on<AddActiveExerciseSet>((event, emit) async {

      DBHelper.instance.addActiveExerciseSet(
          ActiveExerciseSet(
            activeExerciseGroupId: event.activeExerciseGroupId,
            workoutId: state.workout!.workoutId!
          )
      );

      List<ActiveExerciseGroup> activeExerciseGroups = await DBHelper.instance.getActiveExerciseGroupsByWorkoutId(state.workout!.workoutId!);

      List<ActiveExerciseSet> activeExerciseSets = [];

      for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
        List<ActiveExerciseSet> activeExerciseBunch = await DBHelper.instance
            .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
        activeExerciseSets.addAll(activeExerciseBunch);
      }

      emit(state.copyWith(
          activeExerciseSets: () => activeExerciseSets
      ));
    });

    on<DeleteActiveExerciseSet>((event, emit) async {
      await DBHelper.instance.deleteActiveExerciseSet(event.activeExerciseSetId);

      List<ActiveExerciseGroup> activeExerciseGroups = await DBHelper.instance.getActiveExerciseGroupsByWorkoutId(state.workout!.workoutId!);

      List<ActiveExerciseSet> activeExerciseSets = [];

      for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
        List<ActiveExerciseSet> activeExerciseBunch = await DBHelper.instance
            .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
        activeExerciseSets.addAll(activeExerciseBunch);
      }

      emit(state.copyWith(
          activeExerciseSets: () => activeExerciseSets
      ));
    });
  }
}