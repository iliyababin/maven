part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object> get props => [];
}

class InitializeTemplateBloc extends TemplateEvent {}

class AddTemplate extends TemplateEvent {
  final Template template;
  final List<ExerciseBlockData> exerciseBlocks;

  const AddTemplate({
    required this.template,
    required this.exerciseBlocks
  });

  @override
  List<Object> get props => [template, exerciseBlocks];
}

class ReorderTemplates extends TemplateEvent {
  final List<Template> templates;

  const ReorderTemplates({
    required this.templates
  });

  @override
  List<Object> get props => [templates];
}

class DeleteTemplate extends TemplateEvent {
  final int templateId;

  const DeleteTemplate(this.templateId);

  @override
  List<Object> get props => [templateId];
}

class AddTemplateFolder extends TemplateEvent {
  final TemplateFolder templateFolder;

  const AddTemplateFolder({
    required this.templateFolder,
  });

  @override
  List<Object> get props => [templateFolder];
}

class LoadTemplateFolders extends TemplateEvent {}

class UpdateTemplateFolder extends TemplateEvent {
  final TemplateFolder templateFolder;

  const UpdateTemplateFolder({
    required this.templateFolder
  });

  @override
  List<Object> get props => [templateFolder];
}

class ReorderTemplateFolders extends TemplateEvent {
  final List<TemplateFolder> templateFolders;


  const ReorderTemplateFolders({
    required this.templateFolders,
  });

  @override
  List<Object> get props => [templateFolders];
}
