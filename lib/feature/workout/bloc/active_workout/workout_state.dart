part of 'workout_bloc.dart';

enum WorkoutStatus {
  initial,
  loading,
  success,
  none,
  active
}

class WorkoutState extends Equatable {
  const WorkoutState({
    this.status = WorkoutStatus.initial,
    this.workout,
    this.pausedWorkouts = const [],
    this.activeExerciseGroups = const [],
    this.activeExerciseSets = const [],
  });

  final WorkoutStatus status;
  final Workout? workout;
  final List<Workout> pausedWorkouts;
  final List<ActiveExerciseGroup> activeExerciseGroups;
  final List<ActiveExerciseSet> activeExerciseSets;


  WorkoutState copyWith({
    WorkoutStatus Function()? status,
    Workout Function()? workout,
    List<Workout> Function()? pausedWorkouts,
    List<ActiveExerciseGroup> Function()? activeExerciseGroups,
    List<ActiveExerciseSet> Function()? activeExerciseSets,
  }) {
    return WorkoutState(
      status: status != null ? status() : this.status,
      workout: workout != null ? workout() : this.workout,
      pausedWorkouts: pausedWorkouts != null ? pausedWorkouts() : this.pausedWorkouts,
      activeExerciseGroups: activeExerciseGroups != null ? activeExerciseGroups() : this.activeExerciseGroups,
      activeExerciseSets: activeExerciseSets != null ? activeExerciseSets() : this.activeExerciseSets,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workout,
    pausedWorkouts,
    activeExerciseGroups,
    activeExerciseSets,
  ];
}