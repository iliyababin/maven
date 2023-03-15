part of 'workout_bloc.dart';

enum WorkoutStatus {
  error,
  initial,
  loading,
  loaded,
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workout,
    this.workoutExerciseGroups = const [],
    this.workoutExerciseSets = const [],
    this.pausedWorkouts = const [],
  });

  final WorkoutStatus status;
  final Workout? workout;
  final List<WorkoutExerciseGroup> workoutExerciseGroups;
  final List<WorkoutExerciseSet> workoutExerciseSets;
  final List<Workout> pausedWorkouts;


  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    Workout Function()? workout,
    List<WorkoutExerciseGroup> Function()? workoutExerciseGroups,
    List<WorkoutExerciseSet> Function()? workoutExerciseSets,
    List<Workout> Function()? pausedWorkouts,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workout: workout != null ? workout() : this.workout,
      workoutExerciseGroups: workoutExerciseGroups != null ? workoutExerciseGroups() : this.workoutExerciseGroups,
      workoutExerciseSets: workoutExerciseSets != null ? workoutExerciseSets() : this.workoutExerciseSets,
      pausedWorkouts: pausedWorkouts != null ? pausedWorkouts() : this.pausedWorkouts,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
    workoutExerciseGroups,
    workoutExerciseSets,
    pausedWorkouts,
  ];
}