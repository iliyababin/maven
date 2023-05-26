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
    this.template = const Template.empty(),
    this.exerciseBundles = const [],
  });

  final TemplateDetailStatus status;
  final Template template;
  final List<ExerciseBundle> exerciseBundles;

  TemplateDetailState copyWith({
    TemplateDetailStatus Function()? status,
    Template Function()? template,
    List<ExerciseBundle> Function()? exerciseBundles,
  }) {
    return TemplateDetailState(
      status: status != null ? status() : this.status,
      template: template != null ? template() : this.template,
      exerciseBundles: exerciseBundles != null ? exerciseBundles() : this.exerciseBundles,
    );
  }

  @override
  List<Object?> get props => [
    status,
    template,
    exerciseBundles,
  ];
}