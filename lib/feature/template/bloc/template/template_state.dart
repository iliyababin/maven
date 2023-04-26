part of 'template_bloc.dart';

enum TemplateStatus {
  initial,
  loading,
  loaded,
  add,
  update,
  delete,
  reorder,
  toggle,
  error,
}

extension TemplateStatusExtension on TemplateStatus {
  bool get isInitial => this == TemplateStatus.initial;
  bool get isLoading => this == TemplateStatus.loading;
  bool get isLoaded => this == TemplateStatus.loaded;
  bool get isAdd => this == TemplateStatus.add;
  bool get isUpdate => this == TemplateStatus.update;
  bool get isDelete => this == TemplateStatus.delete;
  bool get isReorder => this == TemplateStatus.reorder;
  bool get isToggle => this == TemplateStatus.toggle;
  bool get isError => this == TemplateStatus.error;
}

class TemplateState extends Equatable {
  const TemplateState({
    this.status = TemplateStatus.initial,
    this.templates = const [],
  });

  final TemplateStatus status;
  final List<Template> templates;

  TemplateState copyWith({
    TemplateStatus Function()? status,
    List<Template> Function()? templates,
  }) {
    return TemplateState(
      status: status != null ? status() : this.status,
      templates: templates != null ? templates() : this.templates,
    );
  }

  @override
  List<Object?> get props => [
    status,
    templates,
  ];
}