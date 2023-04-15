import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'program_detail_event.dart';
part 'program_detail_state.dart';

class ProgramDetailBloc extends Bloc<ProgramDetailEvent, ProgramDetailState> {
  ProgramDetailBloc() : super(ProgramDetailInitial()) {
    on<ProgramDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
