part of 'program_bloc.dart';

abstract class ProgramEvent extends Equatable {
  const ProgramEvent();
}

class ProgramInitialize extends ProgramEvent {
  const ProgramInitialize();

  @override
  List<Object?> get props => [];
}

class ProgramBuild extends ProgramEvent {
  const ProgramBuild({
    required this.program,
    required this.programTemplates,
  });

  final Program program;
  final List<ProgramTemplate> programTemplates;

  @override
  List<Object?> get props => [
    program,
    programTemplates,
  ];
}

class ProgramDelete extends ProgramEvent {
  const ProgramDelete({
    required this.program,
  });

  final Program program;

  @override
  List<Object?> get props => [
    program,
  ];
}