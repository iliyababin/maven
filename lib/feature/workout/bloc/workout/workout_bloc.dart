common/model/exercise_group.dart';
import 'package:Maven/common/model/exercise_set.dart';
import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/model/exercise_block.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutInitial()) {
    on<LoadWorkoutList>((event, emit) async {
      List<Workout> workouts = await DatabaseHelper.instance.getWorkouts();
      emit(WorkoutLoaded(workouts: workouts));
    });

    on<AddWorkout>((event, emit) async {
      if(state is WorkoutLoaded) {
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

        List<Workout> workouts = await DatabaseHelper.instance.getWorkouts();
        emit(
          WorkoutLoaded(workouts: workouts)
        );
      }
    });

    on<DeleteWorkout>((event, emit) async {
      DatabaseHelper.instance.deleteWorkout(event.workoutId);
      List<Workout> workouts = await DatabaseHelper.instance.getWorkouts();
      emit(
          WorkoutLoaded(workouts: workouts)
      );
    });
  }
}
