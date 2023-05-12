part of 'complete_bloc.dart';

enum CompleteStatus {
  initial,
  loading,
  loaded,
  error,
}

extension CompleteStatusExtension on CompleteStatus {
  bool get isInitial => this == CompleteStatus.initial;
  bool get isLoading => this == CompleteStatus.loading;
  bool get isLoaded => this == CompleteStatus.loaded;
  bool get isError => this == CompleteStatus.error;
}

class CompleteState extends Equatable {
  const CompleteState({
    this.status = CompleteStatus.initial,
    this.completes = const [],
  });

  final CompleteStatus status;
  final List<Complete> completes;

  CompleteState copyWith({
    CompleteStatus Function()? status,
    List<Complete> Function()? completes,
  }) {
    return CompleteState(
      status: status != null ? status() : this.status,
      completes: completes != null ? completes() : this.completes,
    );
  }

  @override
  List<Object?> get props => [
    status,
    completes,
  ];
}
