part of 'program_bloc.dart';

enum ProgramStatus {
  loading,
  loaded,
}

extension ProgramStatusExtension on ProgramStatus {
  bool get isLoading => this == ProgramStatus.loading;
  bool get isLoaded => this == ProgramStatus.loaded;
}


class ProgramState extends Equatable {
  const ProgramState({
    this.status = ProgramStatus.loading,
    this.programs = const [],
  });

  final ProgramStatus status;
  final List<Program> programs;

  ProgramState copyWith({
    ProgramStatus? status,
    List<Program>? programs,
  }) {
    return ProgramState(
      status: status ?? this.status,
      programs: programs ?? this.programs,
    );
  }

  @override
  List<Object?> get props => [
    status,
    programs,
  ];
}
