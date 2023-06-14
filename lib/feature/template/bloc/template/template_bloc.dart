import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maven/database/model/routine_group.dart';
import 'package:maven/database/model/template_tracker.dart';

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
  }

  final TemplateDao templateDao;
  final TemplateTrackerDao templateTrackerDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  Future<void> _initialize(TemplateInitialize event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading,));

    emit(state.copyWith(status: () => TemplateStatus.loaded,));
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

          timer: exerciseBlock.exerciseGroup.timer,
          exerciseId: exerciseBlock.exercise.exerciseId!,
          weightUnit: WeightUnit.lb,
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
            setType: exerciseSet.type,
          ),
        );
      }
    }

    List<Template> templates = await templateDao.getTemplates();
    emit(state.copyWith(
      status: () => TemplateStatus.loaded,
      templates: () => templates,
    ));
  }

  Future<void> _update(TemplateUpdate event, Emitter<TemplateState> emit) async {
    await templateDao.updateTemplate(event.template);

    if(event.exerciseBundles != null) {
      await templateDao.deleteTemplate(event.template);
      add(TemplateCreate(
        template: event.template,
        exerciseBundles: event.exerciseBundles!,
      ));
    }
  }

  Future<void> _reorder(TemplateReorder event, Emitter<TemplateState> emit) async {
    List<Template> templates = event.templates;
    // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
    for (int i = 0; i < templates.length; i++) {
      Template template = templates[i];
      templateDao.updateTemplate(template.copyWith(sort: i + 1));
    }
  }

  Future<void> _delete(TemplateDelete event, Emitter<TemplateState> emit) async {
    await templateDao.deleteTemplate(event.template);
  }
}

