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
    required this.exerciseDays,
  });

  final Program program;
  final List<ExerciseDay> exerciseDays;

  @override
  List<Object?> get props => [
    program,
    exerciseDays,
  ];
}

class ProgramStream extends ProgramEvent {
  const ProgramStream({
    required this.programs,
  });

  final List<Program> programs;

  @override
  List<Object?> get props => [
    programs,
  ];
}