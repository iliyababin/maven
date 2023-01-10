import 'package:Maven/common/model/active_workout.dart';
import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_workout_event.dart';
part 'active_workout_state.dart';

class ActiveWorkoutBloc extends Bloc<ActiveWorkoutEvent, ActiveWorkoutState> {
  ActiveWorkoutBloc() : super(const ActiveWorkoutState()) {
    on<InitializeActiveWorkoutBloc>((event, emit) async {
      emit(state.copyWith(status: () => ActiveWorkoutStatus.loading));

      ActiveWorkout? activeWorkout = await DBHelper.instance.getActiveWorkoutAAA();

      if(activeWorkout == null){
        emit(state.copyWith(
          status: () => ActiveWorkoutStatus.none
        ));
      } else {
        emit(state.copyWith(
          activeWorkout: () => activeWorkout,
          status: () => ActiveWorkoutStatus.active
        ));
      }
    });

    on<ConvertTemplateToWorkout>((event, emit) async {
      emit(state.copyWith(status: () => ActiveWorkoutStatus.loading));

      int activeWorkoutId = await DBHelper.instance.generateWorkoutFromTemplate(event.template.templateId!);
      ActiveWorkout? activeWorkout = await DBHelper.instance.getActiveWorkout(activeWorkoutId);

      emit(state.copyWith(
        activeWorkout: () => activeWorkout!,
        status: () => ActiveWorkoutStatus.active
      ));
    });
  }
}
/*
Future<void> deleteActiveWorkout(int activeWorkoutId) async {
  DBHelper.instance.deleteActiveWorkout(activeWorkoutId);
  DBHelper.instance.deleteActiveExerciseGroupsByActiveWorkoutId(activeWorkoutId);
  DBHelper.instance.deleteActiveExerciseSetsByActiveWorkoutId(activeWorkoutId);
  _activeWorkouts = await DBHelper.instance.getActiveWorkouts();
  notifyListeners();
}

Future<void> generateActiveWorkoutTemplate(BuildContext context, int workoutId) async {
  int test = await Provider.of<ActiveWorkoutProvider>(context, listen: false).generateActiveWorkoutTemplate(workoutId);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", test);
}

void deleteCurrentWorkout(BuildContext context) {
  int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
  //Provider.of<ActiveWorkoutProvider>(context, listen: false).deleteActiveWorkout(currentWorkoutId);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", -1);
}

Future<void> pauseCurrentWorkout(BuildContext context) async {
  int currentWorkoutId = ISharedPrefs.of(context).streamingSharedPreferences.getInt("currentWorkoutId", defaultValue: -1).getValue();
  ActiveWorkout? activeWorkout =  await DBHelper.instance.getActiveWorkout(currentWorkoutId);
  activeWorkout?.isPaused = 1;
  Provider.of<ActiveWorkoutProvider>(context, listen: false).updateActiveWorkout(activeWorkout!);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", -1);
}

void unpauseWorkout(BuildContext context, int activeWorkoutId) async {
  ActiveWorkout? activeWorkout =  await DBHelper.instance.getActiveWorkout(activeWorkoutId);
  activeWorkout?.isPaused = 0;
  Provider.of<ActiveWorkoutProvider>(context, listen: false).updateActiveWorkout(activeWorkout!);
  ISharedPrefs.of(context).streamingSharedPreferences.setInt("currentWorkoutId", activeWorkoutId);
}
*/
