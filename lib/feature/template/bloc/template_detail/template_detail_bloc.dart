import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';
import '../../../exercise/model/exercise_bundle.dart';
import '../../../exercise/model/exercise_group.dart';
import '../../../exercise/model/exercise_set.dart';

part 'template_detail_event.dart';
part 'template_detail_state.dart';

class TemplateDetailBloc extends Bloc<TemplateDetailEvent, TemplateDetailState> {
  TemplateDetailBloc({
    required this.templateDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
    required this.exerciseDao,
  }) : super(const TemplateDetailState()) {
    on<TemplateDetailLoad>(_templateDetailLoad);
  }

  final TemplateDao templateDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;
  final ExerciseDao exerciseDao;

  Future<void> _templateDetailLoad(TemplateDetailLoad event, emit) async {
    emit(state.copyWith(status: () => TemplateDetailStatus.loading));

    List<ExerciseBundle> exerciseBundles = [];

    List<TemplateExerciseGroup> templateExerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(event.templateId);

    for(TemplateExerciseGroup templateExerciseGroup in templateExerciseGroups) {
      Exercise? exercise = await exerciseDao.getExercise(templateExerciseGroup.exerciseId);
      List<TemplateExerciseSet> templateExerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(templateExerciseGroup.templateExerciseGroupId!);

      exerciseBundles.add(ExerciseBundle(
        exercise: exercise!,
        exerciseGroup: ExerciseGroup.from(templateExerciseGroup),
        exerciseSets: templateExerciseSets.map((e) => ExerciseSet.from(e)).toList(),
        barId: templateExerciseGroup.barId
      ));
    }

    Template? template = await templateDao.getTemplate(event.templateId);

    emit(state.copyWith(
      template: () => template ?? const Template.empty(),
      status: () => TemplateDetailStatus.loaded,
      exerciseBundles: () => exerciseBundles,
    ));
  }
}
