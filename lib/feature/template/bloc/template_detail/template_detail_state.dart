part of 'template_detail_bloc.dart';

enum TemplateDetailStatus {
  initial,
  loading,
  loaded,
  error
}

extension TemplateDetailStatusExtension on TemplateDetailStatus {
  bool get isInitial => this == TemplateDetailStatus.initial;
  bool get isLoading => this == TemplateDetailStatus.loading;
  bool get isLoaded => this == TemplateDetailStatus.loaded;
  bool get isError => this == TemplateDetailStatus.error;
}

class TemplateDetailState extends Equatable {
  const TemplateDetailState({
    this.status = TemplateDetailStatus.initial,
    this.exerciseBundles = const [],
  });

  final TemplateDetailStatus status;
  final List<ExerciseBundle> exerciseBundles;

  TemplateDetailState copyWith({
    TemplateDetailStatus Function()? status,
    List<ExerciseBundle> Function()? exerciseBundles,
  }) {
    return TemplateDetailState(
      status: status != null ? status() : this.status,
      exerciseBundles: exerciseBundles != null ? exerciseBundles() : this.exerciseBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exerciseBundles,
  ];
}