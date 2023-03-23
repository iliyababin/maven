part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object> get props => [];
}

class TemplateInitialize extends TemplateEvent {}

class TemplateCreate extends TemplateEvent {
  final String name;
  final List<ExerciseBlock> exerciseBlocks;

  const TemplateCreate({
    required this.name,
    required this.exerciseBlocks
  });

  @override
  List<Object> get props => [name, exerciseBlocks];
}

class TemplateReorder extends TemplateEvent {
  final List<Template> templates;

  const TemplateReorder({
    required this.templates
  });

  @override
  List<Object> get props => [templates];
}

class TemplateMoveToFolder extends TemplateEvent {
  final int oldTemplateIndex;
  final int oldTemplateFolderIndex;
  final int newTemplateIndex;
  final int newTemplateFolderIndex;
  final List<TemplateFolder> templateFolders;

  const TemplateMoveToFolder({
    required this.oldTemplateIndex,
    required this.oldTemplateFolderIndex,
    required this.newTemplateIndex,
    required this.newTemplateFolderIndex,
    required this.templateFolders,
  });

  @override
  List<Object> get props => [
    oldTemplateIndex,
    oldTemplateFolderIndex,
    newTemplateIndex,
    newTemplateFolderIndex,
    templateFolders,
  ];
}

class TemplateDelete extends TemplateEvent {
  final Template template;

  const TemplateDelete({
    required this.template
  });

  @override
  List<Object> get props => [template];
}

class TemplateStreamUpdateTemplates extends TemplateEvent {

  final List<Template> templates;

  const TemplateStreamUpdateTemplates({
    required this.templates,
  });

  @override
  List<Object> get props => [templates];
}

