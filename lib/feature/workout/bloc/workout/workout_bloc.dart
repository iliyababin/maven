import 'dart:developer';

import 'package:Maven/common/model/exercise_group.dart';
import 'package:Maven/common/model/exercise_set.dart';
import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/model/exercise_block.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(const WorkoutState()) {

    ///
    /// Initialize
    ///

    on<InitializeWorkoutBloc>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      await Future.delayed(Duration(seconds: 2));

      List<Workout> workouts = await DBHelper.instance.getWorkouts();
      List<WorkoutFolder> workoutFolders = await DBHelper.instance.getWorkoutFolders();

      emit(state.copyWith(
        workouts: () => workouts,
        workoutFolders: () => workoutFolders,
        status: () => WorkoutStatus.success
      ));
    });

    ///
    /// Workout
    ///

    on<AddWorkout>((event, emit) async {
      log("trying to add workout");
      if(state.status == WorkoutStatus.success) {
        log("Iin");
        emit(state.copyWith(status: () => WorkoutStatus.loading));

        int workoutId = await DBHelper.instance.addWorkout(event.workout);

        for (var exerciseBlock in event.exerciseBlocks) {
          int exerciseGroupId = await DBHelper.instance.addExerciseGroup(
              ExerciseGroup(
                  exerciseId: exerciseBlock.exercise.exerciseId,
                  workoutId: workoutId
              )
          );
          for (var tempExerciseSet in exerciseBlock.sets) {
            DBHelper.instance.addExerciseSet(
                ExerciseSet(
                    exerciseGroupId: exerciseGroupId,
                    weight: tempExerciseSet.weight,
                    reps: tempExerciseSet.reps,
                    workoutId: workoutId
                )
            );
          }
        }

        emit(state.copyWith(status: () => WorkoutStatus.added));

        List<Workout> workouts = await DBHelper.instance.getWorkouts();
        emit(state.copyWith(
            workouts: () => workouts,
            status: () => WorkoutStatus.success
        ));
        log("Added Workout: ${workoutId}");
      } else {
        log("didnt add workout");
      }
    });

    on<ReorderWorkouts>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.reordering));

      List<Workout> workouts = event.workouts;

      // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
      for (int i = 0; i < workouts.length; i++) {
        Workout workout = workouts[i];
        workout.sortOrder = i;
        int test = await DBHelper.instance.updateWorkout(workout);
      }

      emit(state.copyWith(
        workouts: () => workouts,
        status: () => WorkoutStatus.success
      ));
    });

    ///
    /// WorkoutFolder
    ///

    on<AddWorkoutFolder>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      await DBHelper.instance.addWorkoutFolder(event.workoutFolder);

      List<WorkoutFolder> workoutFolders = await DBHelper.instance.getWorkoutFolders();

      emit(state.copyWith(
        workoutFolders: () => workoutFolders,
        status: () => WorkoutStatus.success
      ));
    });

    on<UpdateWorkoutFolder>((event, emit) async {
      await DBHelper.instance.updateWorkoutFolder(event.workoutFolder);

      List<WorkoutFolder> workoutFolders = await DBHelper.instance.getWorkoutFolders();

      emit(state.copyWith(
        workoutFolders: () => workoutFolders,
        status: () => WorkoutStatus.success
      ));
    });

    on<ReorderWorkoutFolders>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.reordering));

      List<WorkoutFolder> workoutFolders = event.workoutFolders;

      // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
      for (int i = 0; i < workoutFolders.length; i++) {
        WorkoutFolder workoutFolder = workoutFolders[i];
        workoutFolder.sortOrder = i;
        int test = await DBHelper.instance.updateWorkoutFolder(workoutFolder);
      }

      emit(state.copyWith(
          workoutFolders: () => workoutFolders,
        status: () => WorkoutStatus.success
      ));
    });
  }
}
