import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../exercise/dao/exercise_dao.dart';
import '../../../exercise/model/exercise.dart';
import '../../../exercise/model/exercise_bundle.dart';
import '../../../exercise/model/exercise_group.dart';
import '../../../exercise/model/exercise_set.dart';
import '../../dao/template_exercise_group_dao.dart';
import '../../dao/template_exercise_set_dao.dart';
import '../../model/template_exercise_group.dart';
import '../../model/template_exercise_set.dart';

part 'template_detail_event.dart';
part 'template_detail_state.dart';

class TemplateDetailBloc extends Bloc<TemplateDetailEvent, TemplateDetailState> {
  TemplateDetailBloc({
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
    required this.exerciseDao,
  }) : super(const TemplateDetailState()) {
    on<TemplateDetailLoad>(_templateDetailLoad);
  }

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

    emit(state.copyWith(
      status: () => TemplateDetailStatus.loaded,
      exerciseBundles: () => exerciseBundles,
    ));
  }
}
