part of 'template_folder_bloc.dart';

enum TemplateFolderStatus {
  loading,
  loaded,
  error, toggle,
}

class TemplateFolderState extends Equatable {
  const TemplateFolderState({
    this.status = TemplateFolderStatus.loading,
    this.templateFolders = const [],
  });

  final TemplateFolderStatus status;
  final List<TemplateFolder> templateFolders;

  TemplateFolderState copyWith({
    TemplateFolderStatus Function()? status,
    List<TemplateFolder> Function()? templateFolders,
  }) {
    return TemplateFolderState(
      status: status != null ? status() : this.status,
      templateFolders: templateFolders != null ? templateFolders() : this.templateFolders,
    );
  }

  @override
  List<Object?> get props => [
    status,
    templateFolders
  ];
}