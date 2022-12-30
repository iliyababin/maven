import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_workout_event.dart';
part 'active_workout_state.dart';

class ActiveWorkoutBloc extends Bloc<ActiveWorkoutEvent, ActiveWorkoutState> {
  ActiveWorkoutBloc() : super(ActiveWorkoutInitial()) {
    on<ActiveWorkoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
