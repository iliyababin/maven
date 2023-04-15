part of 'program_detail_bloc.dart';

enum ProgramDetailStatus {
  initial,
  loading,
  loaded,
  error,
}

extension ProgramDetailStatusExtension on ProgramDetailStatus {
  bool get isInitial => this == ProgramDetailStatus.initial;
  bool get isLoading => this == ProgramDetailStatus.loading;
  bool get isLoaded => this == ProgramDetailStatus.loaded;
  bool get isError => this == ProgramDetailStatus.error;
}

class ProgramDetailState extends Equatable {
  const ProgramDetailState({
    this.status = ProgramDetailStatus.initial,
    this.program,
    this.folders = const [],
  });

  final ProgramDetailStatus status;
  final Program? program;
  final List<Folder> folders;

  ProgramDetailState copyWith({
    ProgramDetailStatus Function()? status,
    Program Function()? program,
    List<Folder> Function()? folders,
  }) {
    return ProgramDetailState(
      status: status != null ? status() : this.status,
      program: program != null ? program() : this.program,
      folders: folders != null ? folders() : this.folders,
    );
  }

  @override
  List<Object?> get props => [
    status,
    program,
    folders,
  ];
}