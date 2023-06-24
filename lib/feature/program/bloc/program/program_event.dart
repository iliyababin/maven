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
    required this.programTemplateBundles,
  });

  final Program program;
  final List<ProgramTemplateBundle> programTemplateBundles;

  @override
  List<Object?> get props => [
    program,
    programTemplateBundles,
  ];
}