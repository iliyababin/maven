import 'package:Maven/common/model/exercise_group.dart';
import 'package:Maven/common/model/exercise_set.dart';
import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/model/exercise_block.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(const WorkoutState()) {

    on<LoadWorkoutList>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      await Future.delayed(Duration(seconds: 2));

      List<Workout> workouts = await DatabaseHelper.instance.getWorkouts();

      emit(state.copyWith(
        workouts: () => workouts,
        status: () => WorkoutStatus.success
      ));
    });

    on<AddWorkout>((event, emit) async {
      if(state.status == WorkoutStatus.success) {
        emit(state.copyWith(status: () => WorkoutStatus.loading));

        int workoutId = await DatabaseHelper.instance.addWorkout(event.workout);

        for (var exerciseBlock in event.exerciseBlocks) {
          int exerciseGroupId = await DatabaseHelper.instance.addExerciseGroup(
              ExerciseGroup(
                  exerciseId: exerciseBlock.exercise.exerciseId,
                  workoutId: workoutId
              )
          );
          for (var tempExerciseSet in exerciseBlock.sets) {
            DatabaseHelper.instance.addExerciseSet(
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

        List<Workout> workouts = await DatabaseHelper.instance.getWorkouts();
        emit(state.copyWith(
            workouts: () => workouts,
            status: () => WorkoutStatus.success
        ));
      }
    });
  }
}
