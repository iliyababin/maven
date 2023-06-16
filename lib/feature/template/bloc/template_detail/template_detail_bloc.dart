import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/dao/dao.dart';
import '../../../../database/model/model.dart';
import '../../../exercise/model/exercise_bundle.dart';

part 'template_detail_event.dart';
part 'template_detail_state.dart';

class TemplateDetailBloc extends Bloc<TemplateDetailEvent, TemplateDetailState> {
  TemplateDetailBloc({
    required this.templateDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
    required this.exerciseDao,
    required this.templateExerciseSetDataDao,
    required this.exerciseFieldDao,
  }) : super(const TemplateDetailState()) {
    on<TemplateDetailLoad>(_templateDetailLoad);
  }

  final TemplateDao templateDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;
  final TemplateExerciseSetDataDao templateExerciseSetDataDao;
  final ExerciseDao exerciseDao;
  final ExerciseFieldDao exerciseFieldDao;

  Future<void> _templateDetailLoad(TemplateDetailLoad event, emit) async {
    emit(state.copyWith(status: TemplateDetailStatus.loading));

    List<ExerciseBundle> exerciseBundles = [];

    List<TemplateExerciseGroup> templateExerciseGroups = await templateExerciseGroupDao.getTemplateExerciseGroupsByTemplateId(event.templateId);

    for(TemplateExerciseGroup templateExerciseGroup in templateExerciseGroups) {
      Exercise? exercise = await exerciseDao.getExercise(templateExerciseGroup.exerciseId);

      exercise = exercise?.copyWith(fields: await exerciseFieldDao.getExerciseFieldsByExerciseId(exercise.id!));

      List<TemplateExerciseSet> templateExerciseSets = await templateExerciseSetDao.getTemplateExerciseSetsByTemplateExerciseGroupId(templateExerciseGroup.id!);

      List<TemplateExerciseSet> hey = [];

      for (TemplateExerciseSet templateExerciseSet in templateExerciseSets) {
        List<TemplateExerciseSetData> data = await templateExerciseSetDataDao.getTemplateExerciseSetDataByExerciseSetId(templateExerciseSet.id!);
        hey.add(templateExerciseSet.copyWith(data: data));
      }

      exerciseBundles.add(ExerciseBundle(
        exercise: exercise!,
        exerciseGroup: templateExerciseGroup,
        exerciseSets: hey,
        barId: templateExerciseGroup.barId
      ));
    }

    Template? template = await templateDao.getTemplate(event.templateId);

    emit(state.copyWith(
      template: template,
      status: TemplateDetailStatus.loaded,
      exerciseBundles: exerciseBundles,
    ));
  }
}
