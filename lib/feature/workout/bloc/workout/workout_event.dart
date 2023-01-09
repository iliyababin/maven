part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class InitializeWorkoutBloc extends WorkoutEvent {}

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

class ReorderWorkouts extends WorkoutEvent {
  final List<Workout> workouts;

  const ReorderWorkouts({
    required this.workouts
  });

  @override
  List<Object> get props => [workouts];
}

class DeleteWorkout extends WorkoutEvent {
  final int workoutId;

  const DeleteWorkout(this.workoutId);

  @override
  List<Object> get props => [workoutId];
}

class AddWorkoutFolder extends WorkoutEvent {
  final WorkoutFolder workoutFolder;

  const AddWorkoutFolder({
    required this.workoutFolder,
  });

  @override
  List<Object> get props => [workoutFolder];
}

class LoadWorkoutFolders extends WorkoutEvent {}

class UpdateWorkoutFolder extends WorkoutEvent {
  final WorkoutFolder workoutFolder;

  const UpdateWorkoutFolder({
    required this.workoutFolder
  });

  @override
  List<Object> get props => [workoutFolder];
}

class ReorderWorkoutFolders extends WorkoutEvent {
  final List<WorkoutFolder> workoutFolders;


  const ReorderWorkoutFolders({
    required this.workoutFolders,
  });

  @override
  List<Object> get props => [workoutFolders];
}