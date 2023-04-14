import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/program.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  ProgramBloc() : super(const ProgramState()) {
    on<ProgramInitial>(_initial);
  }

  FutureOr<void> _initial(ProgramInitial event, Emitter<ProgramState> emit) {
    emit(state.copyWith(status: () => ProgramStatus.loading,));
    
    emit(state.copyWith(status: () => ProgramStatus.loaded,));
  }
}
