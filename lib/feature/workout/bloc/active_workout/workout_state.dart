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
    this.exercises = const [],
    this.exerciseGroups = const [],
    this.exerciseSets = const [],
    this.pausedWorkouts = const [],
  });

  final WorkoutStatus status;
  final Workout? workout;
  final List<Exercise> exercises;
  final List<ExerciseGroup> exerciseGroups;
  final List<ExerciseSet> exerciseSets;
  final List<Workout> pausedWorkouts;


  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    Workout Function()? workout,
    List<ExerciseGroup> Function()? exerciseGroups,
    List<Exercise> Function()? exercises,
    List<ExerciseSet> Function()? exerciseSets,
    List<Workout> Function()? pausedWorkouts,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workout: workout != null ? workout() : this.workout,
      exercises: exercises != null ? exercises() : this.exercises,
      exerciseGroups: exerciseGroups != null ? exerciseGroups() : this.exerciseGroups,
      exerciseSets: exerciseSets != null ? exerciseSets() : this.exerciseSets,
      pausedWorkouts: pausedWorkouts != null ? pausedWorkouts() : this.pausedWorkouts,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
    exercises,
    exerciseGroups,
    exerciseSets,
    pausedWorkouts,
  ];
}