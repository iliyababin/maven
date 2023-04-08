part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object> get props => [];
}

class TemplateInitialize extends TemplateEvent {}

class TemplateCreate extends TemplateEvent {
  final Template template;
  final List<ExerciseBundle> exerciseBundles;

  const TemplateCreate({
    required this.template,
    required this.exerciseBundles,
  });
}

class TemplateUpdate extends TemplateEvent {
  const TemplateUpdate({
    required this.template,
    required this.exerciseBundles
  });

  final Template template;
  final List<ExerciseBundle>? exerciseBundles;
}

class TemplateDelete extends TemplateEvent {
  final Template template;

  const TemplateDelete({
    required this.template
  });
}

class TemplateReorder extends TemplateEvent {
  final List<Template> templates;

  const TemplateReorder({
    required this.templates,
  });
}

class TemplateStreamUpdateTemplates extends TemplateEvent {

  final List<Template> templates;

  const TemplateStreamUpdateTemplates({
    required this.templates,
  });
}

