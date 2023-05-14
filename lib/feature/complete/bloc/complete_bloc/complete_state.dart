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
    this.completeBundles = const [],
  });

  final CompleteStatus status;
  final List<CompleteBundle> completeBundles;

  CompleteState copyWith({
    CompleteStatus Function()? status,
    List<CompleteBundle> Function()? completeBundles,
  }) {
    return CompleteState(
      status: status != null ? status() : this.status,
      completeBundles: completeBundles != null ? completeBundles() : this.completeBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    completeBundles,
  ];
}
