part of 'program_detail_bloc.dart';

abstract class ProgramDetailEvent extends Equatable {
  const ProgramDetailEvent();
}

class ProgramDetailInitialize extends ProgramDetailEvent {
  @override
  List<Object?> get props => [];
}

class ProgramDetailLoad extends ProgramDetailEvent {
  const ProgramDetailLoad({
    required this.programId,
  });

  final int programId;

  @override
  List<Object?> get props => [
    programId,
  ];
}

class ProgramDetailTemplateTrackerUpdate extends ProgramDetailEvent {
  const ProgramDetailTemplateTrackerUpdate({
    required this.templateTracker,
  });

  final TemplateTracker templateTracker;

  @override
  List<Object?> get props => [
    templateTracker,
  ];
}