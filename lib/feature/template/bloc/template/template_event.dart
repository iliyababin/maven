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
    required this.exerciseBundles,
  });

  final Template template;
  final List<ExerciseBundle> exerciseBundles;

  @override
  List<Object?> get props => [
    template,
    exerciseBundles,
  ];
}

class TemplateUpdate extends TemplateEvent {
  const TemplateUpdate({
    required this.template,
    required this.exerciseBundles
  });

  final Template template;
  final List<ExerciseBundle>? exerciseBundles;

  @override
  List<Object?> get props => [
    template,
    exerciseBundles,
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
    required this.templates,
  });

  final List<Template> templates;

  @override
  List<Object?> get props => [
    templates,
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

