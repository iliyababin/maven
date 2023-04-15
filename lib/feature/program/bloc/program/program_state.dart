part of 'program_bloc.dart';

enum ProgramStatus {
  initial,
  loading,
  loaded,
}

extension ProgramStatusExtension on ProgramStatus {
  bool get isInitial => this == ProgramStatus.initial;
  bool get isLoading => this == ProgramStatus.loading;
  bool get isLoaded => this == ProgramStatus.loaded;
}


class ProgramState extends Equatable {
  const ProgramState({
    this.status = ProgramStatus.initial,
    this.programs = const [],
  });

  final ProgramStatus status;
  final List<Program> programs;

  ProgramState copyWith({
    ProgramStatus Function()? status,
    List<Program> Function()? programs,
  }) {
    return ProgramState(
      status: status != null ? status() : this.status,
      programs: programs != null ? programs() : this.programs,
    );
  }

  @override
  List<Object?> get props => [
    status,
    programs,
  ];
}