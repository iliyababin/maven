part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object> get props => [];
}

class TemplateInitialize extends TemplateEvent {}


class TemplateCreate extends TemplateEvent {
  final String name;
  final List<ExerciseGroup> exerciseGroups;

  const TemplateCreate({
    required this.name,
    required this.exerciseGroups
  });

  @override
  List<Object> get props => [name, exerciseGroups];
}

class TemplateGetExerciseGroups extends TemplateEvent {
  final int templateId;

  const TemplateGetExerciseGroups({required this.templateId});


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

  const TemplateMoveToFolder({
    required this.oldTemplateIndex,
    required this.oldTemplateFolderIndex,
    required this.newTemplateIndex,
    required this.newTemplateFolderIndex,
  });

  @override
  List<Object> get props => [
    oldTemplateIndex,
    oldTemplateFolderIndex,
    newTemplateIndex,
    newTemplateFolderIndex,
  ];
}

class TemplateDelete extends TemplateEvent {
  final int templateId;

  const TemplateDelete(this.templateId);

  @override
  List<Object> get props => [templateId];
}


class TemplateFolderAdd extends TemplateEvent {
  final String name;

  const TemplateFolderAdd({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class TemplateFolderUpdate extends TemplateEvent {
  final TemplateFolder templateFolder;

  const TemplateFolderUpdate({
    required this.templateFolder
  });

  @override
  List<Object> get props => [templateFolder];
}

class TemplateFolderToggle extends TemplateEvent {
  final TemplateFolder templateFolder;

  const TemplateFolderToggle({
    required this.templateFolder
  });
  @override
  List<Object> get props => [templateFolder];
}

class TemplateFolderReorder extends TemplateEvent {
  final List<TemplateFolder> templateFolders;

  const TemplateFolderReorder({
    required this.templateFolders,
  });

  @override
  List<Object> get props => [templateFolders];
}

class TemplateStreamUpdateTemplates extends TemplateEvent {

  final List<Template> templates;

  const TemplateStreamUpdateTemplates({
    required this.templates,
  });

  @override
  List<Object> get props => [templates];
}

class TemplateStreamUpdateTemplateFolders extends TemplateEvent {
  final List<TemplateFolder> templateFolders;

  const TemplateStreamUpdateTemplateFolders({
    required this.templateFolders,
  });

  @override
  List<Object> get props => [templateFolders];
}