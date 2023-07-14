import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';
import '../../../note/note.dart';
import '../../model/template.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc({
    required this.exerciseDao,
    required this.routineDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
    required this.templateDataDao,
    required this.exerciseGroupService,
  }) : super(const TemplateState()) {
    on<TemplateInitialize>(_initialize);
    on<TemplateCreate>(_create);
    on<TemplateUpdate>(_update);
    on<TemplateDelete>(_delete);
    on<TemplateReorder>(_reorder);
  }

  final ExerciseDao exerciseDao;
  final RoutineDao routineDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;
  final TemplateDataDao templateDataDao;

  final ExerciseGroupService exerciseGroupService;

  Future<void> _initialize(TemplateInitialize event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(
      status: TemplateStatus.loaded,
      templates: await _getTemplates(),
    ));
  }

  Future<void> _create(TemplateCreate event, emit) async {
    emit(state.copyWith(
      status: TemplateStatus.loading,
    ));

    int routineId = await routineDao.add(
      Routine(
        id: event.template.id,
        name: event.template.name,
        note: event.template.note,
        timestamp: DateTime.now(),
        type: RoutineType.template,
      ),
    );

    await templateDataDao.add(TemplateData(
      routineId: routineId,
      sort: -1,
    ));

    for (ExerciseGroup exerciseGroup in event.template.exerciseGroups) {
      int exerciseGroupId = await exerciseGroupDao.add(
        exerciseGroup.copyWith(routineId: routineId),
      );

      for (ExerciseSet exerciseSet in exerciseGroup.sets) {
        int exerciseSetId = await exerciseSetDao.add(
          exerciseSet.copyWith(exerciseGroupId: exerciseGroupId),
        );

        for (ExerciseSetData exerciseSetData in exerciseSet.data) {
          await exerciseSetDataDao.add(
            exerciseSetData.copyWith(exerciseSetId: exerciseSetId),
          );
        }
      }

      for (Note note in exerciseGroup.notes) {
        await noteDao.add(
          note.copyWith(exerciseGroupId: exerciseGroupId),
        );
      }
    }

    emit(state.copyWith(
      status: TemplateStatus.loaded,
      templates: await _getTemplates(),
    ));
  }

  Future<void> _update(TemplateUpdate event, Emitter<TemplateState> emit) async {
    emit(state.copyWith(
      status: TemplateStatus.loading,
    ));

    await routineDao.remove(event.routine);

    if (event.exerciseGroups != null) {
      add(TemplateCreate(
        template: Template(
          id: event.routine.id,
          name: event.routine.name,
          note: event.routine.note,
          timestamp: event.routine.timestamp,
          type: event.routine.type,
          exerciseGroups: event.exerciseGroups!,
        ),
      ));
    }
  }

  Future<void> _reorder(TemplateReorder event, Emitter<TemplateState> emit) async {
    Template template = state.templates.removeAt(event.oldIndex);
    state.templates.insert(event.newIndex, template);
    for (int i = 0; i < state.templates.length; i++) {
      Template template = state.templates[i];
      templateDataDao.modify(template.data!.copyWith(sort: i + 1));
    }
    emit(state.copyWith(
      templates: await _getTemplates(),
    ));
  }

  Future<void> _delete(TemplateDelete event, Emitter<TemplateState> emit) async {
    await routineDao.remove(event.template);
    emit(state.copyWith(
      templates: await _getTemplates(),
    ));
  }

  Future<List<Template>> _getTemplates() async {
    List<Template> templates = [];

    for(TemplateData data in await templateDataDao.getAll()) {
      Routine? routine = await routineDao.get(data.routineId);
      List<ExerciseGroup> groups = await exerciseGroupService.getByRoutineId(data.routineId);

      templates.add(Template(
        id: routine!.id,
        type: routine.type,
        name: routine.name,
        timestamp: routine.timestamp,
        note: routine.note,
        data: data,
        exerciseGroups: groups,
        musclePercentages: await exerciseGroupService.getMusclePercentages(groups),
        duration: exerciseGroupService.getDuration(groups),
        volume: await exerciseGroupService.getVolume(groups),
      ));
    }

    return templates;
  }
}
/*
Exercise? exercise = await exerciseDao.getExercise(exerciseGroup.exerciseId);
if (muscleAmounts.containsKey(exercise!.muscle)) {
muscleAmounts[exercise.muscle] = muscleAmounts[exercise.muscle]! + 1;
} else {
muscleAmounts[exercise.muscle] = 1;
}

Map<Muscle, double> musclePercentages = {};
for (Muscle muscle in muscleAmounts.keys) {
musclePercentages[muscle] = muscleAmounts[muscle]! / exerciseGroups.length;
}*/
