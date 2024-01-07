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
    required this.routine,
    required this.exerciseList,
  });

  final Routine routine;
  final ExerciseList exerciseList;

  @override
  List<Object?> get props => [
        routine,
        exerciseList,
      ];
}

class TemplateUpdate extends TemplateEvent {
  const TemplateUpdate({
    required this.routine,
    required this.exerciseList,
  });

  final Routine routine;
  final ExerciseList exerciseList;

  @override
  List<Object?> get props => [
        routine,
        exerciseList,
      ];
}

class TemplateDelete extends TemplateEvent {
  const TemplateDelete({required this.template});

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
