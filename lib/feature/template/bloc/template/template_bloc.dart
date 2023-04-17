import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../exercise/model/exercise_bundle.dart';
import '../../dao/template_dao.dart';
import '../../dao/template_exercise_group_dao.dart';
import '../../dao/template_exercise_set_dao.dart';
import '../../model/template.dart';
import '../../model/template_exercise_group.dart';
import '../../model/template_exercise_set.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc({
    required this.templateDao,
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

    List<int> highestSortOrder = await templateDao.getHighestSortOrder();
    int largestInt;
    if (highestSortOrder.isNotEmpty) {
      largestInt = highestSortOrder.reduce((value, element) => value > element ? value : element) + 1;
    } else {
      largestInt = 1; // or whatever default value you want to use
    }
    int templateId = await templateDao.addTemplate(event.template.copyWith(sortOrder: largestInt));

    for (ExerciseBundle exerciseBlock in event.exerciseBundles) {
      int exerciseGroupId = await templateExerciseGroupDao.addTemplateExerciseGroup(
        TemplateExerciseGroup(
          restTimed: exerciseBlock.exerciseGroup.restTimed,
          exerciseId: exerciseBlock.exercise.exerciseId,
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
      // await templateExerciseSetDao.deleteExerciseSetsByTemplateId(event.template.templateId!);
      // await templateExerciseGroupDao.deleteTemplateExerciseGroupsByTemplateId(event.template.templateId!);
      await templateDao.deleteTemplate(event.template);
      add(TemplateCreate(template: event.template, exerciseBundles: event.exerciseBundles!));
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

