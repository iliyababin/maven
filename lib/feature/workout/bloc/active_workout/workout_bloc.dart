
import 'package:Maven/common/util/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/model/template.dart';
import '../../../../common/model/workout.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(const WorkoutState()) {
    on<InitializeWorkoutBloc>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      Workout? workout = await DBHelper.instance.getWorkoutAAA();

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      if(workout == null){
        emit(state.copyWith(
          status: () => WorkoutStatus.none,
          pausedWorkouts: () => pausedWorkouts

        ));
      } else {
        emit(state.copyWith(
          workout: () => workout,
          status: () => WorkoutStatus.active,
          pausedWorkouts: () => pausedWorkouts
        ));
      }
    });

    on<ConvertTemplateToWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      int workoutId = await DBHelper.instance.generateWorkoutFromTemplate(event.template.templateId!);
      Workout? workout = await DBHelper.instance.getWorkout(workoutId);

      emit(state.copyWith(
          workout: () => workout!,
        status: () => WorkoutStatus.active
      ));
    });

    on<PauseWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      if(state.workout == null) return;

      Workout? workout = await DBHelper.instance.getWorkout(state.workout?.workoutId ?? 0);
      workout?.isPaused = 1;

      await DBHelper.instance.updateWorkout(workout!);

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts
      ));
    });

    on<UnpauseWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      Workout workout = event.workout;
      workout.isPaused = 0;

      await DBHelper.instance.updateWorkout(workout);

      Workout? updatedWorkout = await DBHelper.instance.getWorkoutAAA();

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      emit(state.copyWith(
          workout: () => updatedWorkout!,
          status: () => WorkoutStatus.active,
          pausedWorkouts: () => pausedWorkouts
      ));
    });

    on<DeleteActiveWorkout>((event, emit) async {
      emit(state.copyWith(status: () => WorkoutStatus.loading));

      int workoutId = state.workout?.workoutId! ?? -1;
      DBHelper.instance.deleteWorkout(workoutId);
      DBHelper.instance.deleteActiveExerciseGroupsByWorkoutId(workoutId);
      DBHelper.instance.deleteActiveExerciseSetsByWorkoutId(workoutId);

      List<Workout> pausedWorkouts = await DBHelper.instance.getPausedWorkouts();

      emit(state.copyWith(
        status: () => WorkoutStatus.none,
        pausedWorkouts: () => pausedWorkouts
      ));
    });
  }
}
/*
Future<void> deleteWorkout(int WorkoutId) async {
  DBHelper.instance.deleteWorkout(WorkoutId);
  DBHelper.instance.deleteActiveExerciseGroupsByWorkoutId(WorkoutId);
  DBHelper.instance.deleteActiveExerciseSetsByWorkoutId(WorkoutId);
  _Workouts = await DBHelper.instance.getWorkouts();
  notifyListeners();
}

Future<void> generateWorkoutTemplate(BuildContext context, int workoutId) async {
  int test = await Provider.of<WorkoutProvider>(context, listen: false).generateWorkoutTemplate(workoutId);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", test);
}

void deleteCurrentWorkout(BuildContext context) {
  int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
  //Provider.of<WorkoutProvider>(context, listen: false).deleteWorkout(currentWorkoutId);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", -1);
}

Future<void> pauseCurrentWorkout(BuildContext context) async {
  int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
  Workout? Workout =  await DBHelper.instance.getWorkout(currentWorkoutId);
  Workout?.isPaused = 1;
  Provider.of<WorkoutProvider>(context, listen: false).updateWorkout(Workout!);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", -1);
}

void unpauseWorkout(BuildContext context, int WorkoutId) async {
  Workout? Workout =  await DBHelper.instance.getWorkout(WorkoutId);
  Workout?.isPaused = 0;
  Provider.of<WorkoutProvider>(context, listen: false).updateWorkout(Workout!);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", WorkoutId);
}
*/
