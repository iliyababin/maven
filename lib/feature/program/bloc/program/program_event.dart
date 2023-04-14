part of 'program_bloc.dart';

abstract class ProgramEvent extends Equatable {
  const ProgramEvent();
}

class ProgramInitial extends ProgramEvent {
  @override
  List<Object?> get props => [];
}