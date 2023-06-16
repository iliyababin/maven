import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/database.dart';
import '../../../exercise/model/exercise_bundle.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc({
    required this.templateDao,
    required this.templateTrackerDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
    required this.templateExerciseSetDataDao,
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
  final TemplateExerciseSetDataDao templateExerciseSetDataDao;

  Future<void> _initialize(TemplateInitialize event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading,));

    List<Template> templates = await templateDao.getTemplates();

    emit(state.copyWith(
      status: () => TemplateStatus.loaded,
      templates: () => templates,
    ));
  }


  Future<void> _create(TemplateCreate event, emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading));

    int templateId = await templateDao.addTemplate(event.template);

    for (ExerciseBundle exerciseBlock in event.exerciseBundles) {
      int exerciseGroupId = await templateExerciseGroupDao.addTemplateExerciseGroup(
        TemplateExerciseGroup(
          timer: exerciseBlock.exerciseGroup.timer,
          exerciseId: exerciseBlock.exercise.id!,
          weightUnit: exerciseBlock.exerciseGroup.weightUnit,
          templateId: templateId,
          barId: exerciseBlock.exerciseGroup.barId,
        )
      );
      for (var exerciseSet in exerciseBlock.exerciseSets) {
        int templateExerciseSetId = await templateExerciseSetDao.addTemplateExerciseSet(
          TemplateExerciseSet(
            templateId: templateId,
            exerciseGroupId: exerciseGroupId,
            checked: exerciseSet.checked,
            type: exerciseSet.type,
          ),
        );

        for (ExerciseSetData exerciseSetData in exerciseSet.data) {
          await templateExerciseSetDataDao.addTemplateExerciseSetData(
            TemplateExerciseSetData(
              fieldType: exerciseSetData.fieldType,
              exerciseSetId: templateExerciseSetId,
              value: exerciseSetData.value,
            ),
          );
        }
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

