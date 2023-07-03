part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();
}

class TemplateInitialize extends TemplateEvent {
  const TemplateInitialize();

  @override
  List<Object?> get props => [];
}

class TemplateCreate extends TemplateEvent {
  const TemplateCreate({
    required this.template,
  });

  final Template template;

  @override
  List<Object?> get props => [
    template,
  ];
}

class TemplateUpdate extends TemplateEvent {
  const TemplateUpdate({
    required this.routine,
    required this.exerciseGroups,
  });

  final Routine routine;
  final List<ExerciseGroup>? exerciseGroups;

  @override
  List<Object?> get props => [
    routine,
    exerciseGroups,
  ];
}

class TemplateDelete extends TemplateEvent {
  const TemplateDelete({
    required this.template
  });

  final Template template;

  @override
  List<Object?> get props => [
    template,
  ];
}

class TemplateReorder extends TemplateEvent {
  const TemplateReorder({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;
  final int newIndex;

  @override
  List<Object?> get props => [
    oldIndex,
    newIndex,
  ];
}

class TemplateStreamUpdateTemplates extends TemplateEvent {
  const TemplateStreamUpdateTemplates({
    required this.templates,
  });

  final List<Template> templates;

  @override
  List<Object?> get props => [
    templates,
  ];
}

