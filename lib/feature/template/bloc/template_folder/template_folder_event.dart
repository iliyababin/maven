part of 'template_folder_bloc.dart';

abstract class TemplateFolderEvent extends Equatable {
  const TemplateFolderEvent();

  @override
  List<Object?> get props => [];
}

class TemplateFolderInitialize extends TemplateFolderEvent {}

class TemplateFolderAdd extends TemplateFolderEvent {
  final String name;

  const TemplateFolderAdd({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class TemplateFolderUpdate extends TemplateFolderEvent {
  final TemplateFolder templateFolder;

  const TemplateFolderUpdate({
    required this.templateFolder
  });

  @override
  List<Object> get props => [templateFolder];
}

class TemplateFolderToggle extends TemplateFolderEvent {
  final TemplateFolder templateFolder;

  const TemplateFolderToggle({
    required this.templateFolder
  });
  @override
  List<Object> get props => [templateFolder];
}

class TemplateFolderReorder extends TemplateFolderEvent {
  final List<TemplateFolder> templateFolders;

  const TemplateFolderReorder({
    required this.templateFolders,
  });

  @override
  List<Object> get props => [templateFolders];
}

class TemplateFolderDelete extends TemplateFolderEvent {
  final TemplateFolder templateFolder;

  const TemplateFolderDelete({
    required this.templateFolder,
  });

  @override
  List<Object> get props => [templateFolder];
}

class TemplateStreamUpdateTemplateFolders extends TemplateFolderEvent {
  final List<TemplateFolder> templateFolders;

  const TemplateStreamUpdateTemplateFolders({
    required this.templateFolders,
  });

  @override
  List<Object> get props => [templateFolders];
}