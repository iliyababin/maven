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
    this.template,
    this.exerciseBundles = const [],
  });

  final TemplateDetailStatus status;
  final Template? template;
  final List<ExerciseBundle> exerciseBundles;

  TemplateDetailState copyWith({
    TemplateDetailStatus? status,
    Template? template,
    List<ExerciseBundle>? exerciseBundles,
  }) {
    return TemplateDetailState(
      status: status ?? this.status,
      template: template ?? this.template,
      exerciseBundles: exerciseBundles ?? this.exerciseBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    template,
    exerciseBundles,
  ];
}