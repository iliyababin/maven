import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/database.dart';
import '../../../exercise/model/exercise_list.dart';
import '../../../routine/service/service.dart';
import '../../model/template.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc({
    required this.databaseService,
    required this.routineService,
  }) : super(const TemplateState()) {
    on<TemplateInitialize>(_initialize);
    on<TemplateCreate>(_create);
    on<TemplateUpdate>(_update);
    on<TemplateDelete>(_delete);
    on<TemplateReorder>(_reorder);
  }

  final DatabaseService databaseService;
  final RoutineService routineService;

  Future<void> _initialize(TemplateInitialize event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(
      status: TemplateStatus.loaded,
      templates: await routineService.getTemplates(),
    ));
  }

  Future<void> _create(TemplateCreate event, emit) async {
    emit(state.copyWith(
      status: TemplateStatus.loading,
    ));

    Template template = await routineService.addTemplate(event.routine, event.exerciseList);

    emit(state.copyWith(
      status: TemplateStatus.loaded,
      templates: [...state.templates, template],
    ));
  }

  Future<void> _update(TemplateUpdate event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(
      status: TemplateStatus.loading,
    ));

    Template template = await routineService.updateTemplate(event.routine, event.exerciseList);

    emit(state.copyWith(
      status: TemplateStatus.loaded,
      templates: [...state.templates.where((t) => t.routine.id != template.routine.id), template],
    ));
  }

  Future<void> _reorder(TemplateReorder event, Emitter<TemplateState> emit) async {
    Template template = state.templates.removeAt(event.oldIndex);
    state.templates.insert(event.newIndex, template);
    for (int i = 0; i < state.templates.length; i++) {
      routineService.updateTemplateData(state.templates[i].data.copyWith(sort: i + 1));
    }
  }

  Future<void> _delete(TemplateDelete event, Emitter<TemplateState> emit) async {
    routineService.deleteRoutine(event.template.routine);

    emit(state.copyWith(
      templates: [...state.templates.where((t) => t.routine.id != event.template.routine.id)],
    ));
  }
}