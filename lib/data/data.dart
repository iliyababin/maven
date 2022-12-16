import 'package:maven/model/exercise.dart';
import 'package:maven/model/exercise_group.dart';
import 'package:maven/model/exercise_set.dart';
import 'package:maven/model/workout.dart';

const workouts = [
  {
    "workoutId": "1",
    "name": "Push Day",
  },
  {
    "workoutId": "2",
    "name": "Legs",
  }
];

const exercises = [
  {
    "exerciseId": "1",
    "name": "Bench Press",
    "muscle": "Chest",
    "picture": "cool"
  },
  {
    "exerciseId": "2",
    "name": "Squat",
    "muscle": "Legs",
    "picture": "cool"
  },
  {
    "exerciseId": "3",
    "name": "Deadlift",
    "muscle": "Legs, Back",
    "picture": "cool"
  },
  {
    "exerciseId": "4",
    "name": "Romanian Deadlift",
    "muscle": "",
    "picture": "cool"
  }
];

const exerciseGroups = [
  {
    "exerciseGroupId": "1",
    "exerciseId": "1",
    "workoutId": "1",
  },
  {
    "exerciseGroupId": "2",
    "exerciseId": "2",
    "workoutId": "1",
  },
  {
    "exerciseGroupId": "3",
    "exerciseId": "3",
    "workoutId": "1",
  },
];

const exerciseSets = [
  {
    "exerciseSetId": "1",
    "weight": "225",
    "reps": "10",
    "exerciseGroupId": "1"
  },
  {
    "exerciseSetId": "2",
    "weight": "225",
    "reps": "10",
    "exerciseGroupId": "1"
  },
  {
    "exerciseSetId": "3",
    "weight": "225",
    "reps": "10",
    "exerciseGroupId": "1"
  },
  {
    "exerciseSetId": "4",
    "weight": "10",
    "reps": "5",
    "exerciseGroupId": "2"
  },
];

List<Workout> parsedWorkouts = workouts.map<Workout>(Workout.fromJson).toList();
List<Exercise> parsedExercises = exercises.map<Exercise>(Exercise.fromJson).toList();
List<ExerciseGroup> parsedExerciseGroups = exerciseGroups.map<ExerciseGroup>(ExerciseGroup.fromJson).toList();
List<ExerciseSet> parsedExerciseSets = exerciseSets.map<ExerciseSet>(ExerciseSet.fromJson).toList();

List<ExerciseSet> getExerciseSetsByExerciseGroupId(String exerciseGroupId) {
  return parsedExerciseSets.where((exerciseSet) => exerciseSet.exerciseGroupId == exerciseGroupId).toList();
}

List<ExerciseGroup> getExerciseGroupsById(String workoutId) {
  return parsedExerciseGroups.where((exerciseGroup) => exerciseGroup.workoutId == workoutId).toList();
}

Exercise getExercise(String exerciseId) {
  return parsedExercises.firstWhere((exercise) => exercise.exerciseId == exerciseId);
}

List<Exercise> getAllExercises() {
  return parsedExercises;
}

List<Exercise> getAllExercisesByName(String query) {
  return parsedExercises.where((exercise) => exercise.name.toLowerCase().contains(query.toLowerCase())).toList();
}

List<Workout> getWorkouts() {
  return parsedWorkouts;
}

Workout getWorkout(query) {
  return parsedWorkouts.firstWhere((workout) => workout.workoutId == query);
}