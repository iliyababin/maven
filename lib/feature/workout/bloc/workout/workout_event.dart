part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class LoadWorkoutList extends WorkoutEvent {}

class AddWorkout extends WorkoutEvent {
  final Workout workout;
  final List<ExerciseBlockData> exerciseBlocks;

  const AddWorkout({
    required this.workout,
    required this.exerciseBlocks
  });

  @override
  List<Object> get props => [workout, exerciseBlocks];
}

class DeleteWorkout extends WorkoutEvent {
  final int workoutId;

  const DeleteWorkout(this.workoutId);

  @override
  List<Object> get props => [workoutId];
}