part of 'template_bloc.dart';

enum TemplateStatus {
  loading,
  loaded,
  reorder,
  toggle,
  error,
}

extension TemplateStatusExtension on TemplateStatus {
  bool get isLoading => this == TemplateStatus.loading;
  bool get isLoaded => this == TemplateStatus.loaded;
  bool get isReorder => this == TemplateStatus.reorder;
  bool get isToggle => this == TemplateStatus.toggle;
  bool get isError => this == TemplateStatus.error;
}

class TemplateState extends Equatable {
  const TemplateState({
    this.status = TemplateStatus.loading,
    this.templates = const [],
  });

  final TemplateStatus status;
  final List<Template> templates;

  TemplateState copyWith({
    TemplateStatus? status,
    List<Template>? templates,
  }) {
    return TemplateState(
      status: status ?? this.status,
      templates: templates ?? this.templates,
    );
  }

  @override
  List<Object?> get props => [
    status,
    templates,
  ];
}