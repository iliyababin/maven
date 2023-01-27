part of 'template_bloc.dart';

enum TemplateStatus {
  initial,
  loading,
  success,
  failure,
  added,
  reordering
}

class TemplateState extends Equatable {
  const TemplateState({
    this.status = TemplateStatus.initial,
    this.templates = const [],
    this.templateFolders = const [],
  });

  final TemplateStatus status;
  final List<Template> templates;
  final List<TemplateFolder> templateFolders;

  TemplateState copyWith({
    TemplateStatus Function()? status,
    List<Template> Function()? templates,
    List<TemplateFolder> Function()? templateFolders,
  }) {
    return TemplateState(
      status: status != null ? status() : this.status,
      templates: templates != null ? templates() : this.templates,
      templateFolders: templateFolders != null ? templateFolders() : this.templateFolders,
    );
  }

  @override
  List<Object?> get props => [
    status,
    templates,
    templateFolders,
  ];
}