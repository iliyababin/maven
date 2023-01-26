
import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/template/repository/template_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/model/exercise.dart';
import '../../../../common/model/exercise_group.dart';
import '../../../../common/model/exercise_set.dart';
import '../../../../common/model/template.dart';
import '../../../../common/model/workout.dart';
import '../../repository/workout_repository_impl.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {

  final WorkoutRepositoryImpl workoutRepository;
  final TemplateRepositoryImpl templateRepository;

  WorkoutBloc({
    required this.workoutRepository,
    required this.templateRepository,
  }) : super(const WorkoutState()) {
    on<InitializeWorkoutBloc>((event, emit) async {
      emit(state.copyWith(
        status: () => WorkoutStatus.loading,
      ));

      Workout? workout = await workoutRepository.getWorkoutAAA();
      List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();

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



      int workoutId = await genTem(event.template.templateId!);
      Workout? workout = await workoutRepository.getWorkout(workoutId);

      if(workout == null) {
        print("Error with converting workout");
        return;
      }
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

      Workout? workout = await workoutRepository.getWorkout(state.workout?.workoutId ?? 0);
      workout?.isPaused = 1;

      await workoutRepository.updateWorkout(workout!);

      List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();

      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts,
        activeExerciseGroups: () => [],
        activeExerciseSets: () => [],
      ));
    });

    on<UnpauseWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      Workout workout = event.workout;
      workout.isPaused = 0;

      await workoutRepository.updateWorkout(workout);

      Workout? updatedWorkout = await workoutRepository.getWorkoutAAA();

      List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();

      List<ActiveExerciseGroup> activeExerciseGroups = await DBHelper.instance.getActiveExerciseGroupsByWorkoutId(workout!.workoutId!);

      List<ActiveExerciseSet> activeExerciseSets = [];

      for(ActiveExerciseGroup activeExerciseGroup in activeExerciseGroups){
        List<ActiveExerciseSet> activeExerciseBunch = await DBHelper.instance
            .getActiveExerciseSetsByActiveExerciseGroupId(activeExerciseGroup.activeExerciseGroupId!);
        activeExerciseSets.addAll(activeExerciseBunch);
      }

      emit(state.copyWith(
        workout: () => updatedWorkout!,
        status: () => WorkoutStatus.active,
        pausedWorkouts: () => pausedWorkouts,
        activeExerciseGroups: () => activeExerciseGroups,
        activeExerciseSets: () => activeExerciseSets
      ));
    });

    on<DeleteActiveWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      int workoutId = state.workout?.workoutId! ?? -1;
      workoutRepository.deleteWorkout(workoutId);
      DBHelper.instance.deleteActiveExerciseGroupsByWorkoutId(workoutId);
      DBHelper.instance.deleteActiveExerciseSetsByWorkoutId(workoutId);

      List<Workout> pausedWorkouts = await workoutRepository.getPausedWorkouts();

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
            workoutId: state.workout!.workoutId!,
            weight: 0,
            reps: 0,
            checked: 0
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


    on<UpdateActiveExerciseSet>((event, emit) async {
      await DBHelper.instance.updateActiveExerciseSet(event.activeExerciseSet);
    });
  }

  Future<int> genTem(templateId) async {
    Template? template = await templateRepository.getTemplate(templateId);
    Workout workout = Workout.templateToWorkout(template!);
    int workoutId = await workoutRepository.addWorkout(workout);

    List<ExerciseGroup> exerciseGroups = await DBHelper.instance.getExerciseGroupsByTemplateId(templateId);
    for (var exerciseGroup in exerciseGroups) {
      int activeExerciseGroupId = await DBHelper.instance.addActiveExerciseGroup(ActiveExerciseGroup.exerciseToActiveExerciseGroup(exerciseGroup.exerciseId, workoutId));

      List<ExerciseSet> exerciseSets = await DBHelper.instance.getExerciseSetsByExerciseGroupId(exerciseGroup.exerciseGroupId!);
      for(var exerciseSet in exerciseSets){
        DBHelper.instance.addActiveExerciseSet(ActiveExerciseSet.exerciseSetToActiveExerciseSet(exerciseSet, activeExerciseGroupId, workoutId));
      }
    }
    return workoutId;
  }
}