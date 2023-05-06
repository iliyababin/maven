import 'dart:async';

import 'package:Maven/database/model/template_tracker.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/dao/template_dao.dart';
import '../../../../database/dao/template_exercise_group_dao.dart';
import '../../../../database/dao/template_exercise_set_dao.dart';
import '../../../../database/dao/template_tracker_dao.dart';
import '../../../../database/model/template.dart';
import '../../../../database/model/template_exercise_group.dart';
import '../../../../database/model/template_exercise_set.dart';
import '../../../exercise/model/exercise_bundle.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc({
    required this.templateDao,
    required this.templateTrackerDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
  }) : super(const TemplateState()) {
    on<TemplateInitialize>(_initialize);
    on<TemplateCreate>(_create);
    on<TemplateUpdate>(_update);
    on<TemplateDelete>(_delete);
    on<TemplateReorder>(_reorder);
    on<TemplateStreamUpdateTemplates>(_updateTemplates);
  }

  final TemplateDao templateDao;
  final TemplateTrackerDao templateTrackerDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  Future<void> _initialize(TemplateInitialize event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading,));

    templateDao.getTemplatesAsStream().listen((event) => add(TemplateStreamUpdateTemplates(templates: event)));

    emit(state.copyWith(status: () => TemplateStatus.loaded,));
  }

  Future<void> _updateTemplates(TemplateStreamUpdateTemplates event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(templates: () => event.templates));
  }

  Future<void> _create(TemplateCreate event, emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading));

    int templateId = await templateDao.addTemplate(event.template);

    if (event.templateTracker != null) {
      await templateTrackerDao.addTemplateTracker(event.templateTracker!.copyWith(templateId: templateId));
    }

    for (ExerciseBundle exerciseBlock in event.exerciseBundles) {
      int exerciseGroupId = await templateExerciseGroupDao.addTemplateExerciseGroup(
        TemplateExerciseGroup(
          restTimed: exerciseBlock.exerciseGroup.restTimed,
          exerciseId: exerciseBlock.exercise.exerciseId!,
          templateId: templateId,
          barId: exerciseBlock.exerciseGroup.barId,
        )
      );
      for (var exerciseSet in exerciseBlock.exerciseSets) {
        await templateExerciseSetDao.addTemplateExerciseSet(
          TemplateExerciseSet(
            templateId: templateId,
            templateExerciseGroupId: exerciseGroupId,
            option1: exerciseSet.option1,
            option2: exerciseSet.option2,
          ),
        );
      }
    }

    emit(state.copyWith(status: () => TemplateStatus.loaded));
  }

  Future<void> _update(TemplateUpdate event, Emitter<TemplateState> emit) async {
    await templateDao.updateTemplate(event.template);

    if(event.exerciseBundles != null) {
      await templateDao.deleteTemplate(event.template);
      add(TemplateCreate(
        template: event.template,
        templateTracker: event.template.templateTracker,
        exerciseBundles: event.exerciseBundles!,
      ));
    }
  }

  Future<void> _reorder(TemplateReorder event, Emitter<TemplateState> emit) async {
    List<Template> templates = event.templates;
    // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
    for (int i = 0; i < templates.length; i++) {
      Template template = templates[i];
      templateDao.updateTemplate(template.copyWith(sortOrder: i + 1));
    }
  }

  Future<void> _delete(TemplateDelete event, Emitter<TemplateState> emit) async {
    await templateExerciseSetDao.deleteExerciseSetsByTemplateId(event.template.templateId!);
    await templateExerciseGroupDao.deleteTemplateExerciseGroupsByTemplateId(event.template.templateId!);
    await templateDao.deleteTemplate(event.template);
  }
}

