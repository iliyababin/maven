import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/common.dart';
import '../../../../database/dao/exercise_set_data_dao.dart';
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
        name: event.template.name,
        note: event.template.note,
        timestamp: DateTime.now(),
        sort: (await routineDao.getLargestSort() ?? 0) + 1,
        type: RoutineType.template,
      ),
    );

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
          sort: event.routine.sort,
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
      routineDao.modify(template.copyWith(sort: i + 1));
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

    for (Routine routine in await routineDao.getByType(RoutineType.template)) {
      Timed duration = const Timed.zero();
      // TODO: calculate volume
      int volume = 4269;
      Map<Muscle, int> muscleAmounts = {};

      List<ExerciseGroup> exerciseGroups = [];

      for (BaseExerciseGroup exerciseGroup in await exerciseGroupDao.getByRoutineId(routine.id!)) {
        List<ExerciseSet> exerciseSets = [];
        for (BaseExerciseSet exerciseSet in await exerciseSetDao.getByExerciseGroupId(exerciseGroup.id!)) {
          duration = duration.add(exerciseGroup.timer);
          List<BaseExerciseSetData> exerciseSetData = await exerciseSetDataDao.getByExerciseSetId(exerciseSet.id!);

          exerciseSets.add(ExerciseSet(
            id: exerciseSet.id,
            type: exerciseSet.type,
            checked: exerciseSet.checked,
            exerciseGroupId: exerciseSet.exerciseGroupId,
            data: exerciseSetData
                .map((exerciseSetData) => ExerciseSetData(
                      id: exerciseSetData.id,
                      exerciseSetId: exerciseSetData.exerciseSetId,
                      fieldType: exerciseSetData.fieldType,
                      value: exerciseSetData.value,
                    ))
                .toList(),
          ));
        }

        List<Note> notes = [];
        for (BaseNote note in await noteDao.getByExerciseGroupId(exerciseGroup.id!)) {
          notes.add(Note(
            id: note.id,
            data: note.data,
            exerciseGroupId: note.exerciseGroupId,
          ));
        }

        exerciseGroups.add(ExerciseGroup(
          id: exerciseGroup.id,
          timer: exerciseGroup.timer,
          weightUnit: exerciseGroup.weightUnit,
          distanceUnit: exerciseGroup.distanceUnit,
          exerciseId: exerciseGroup.exerciseId,
          barId: exerciseGroup.barId,
          routineId: exerciseGroup.routineId,
          sets: exerciseSets,
          notes: notes,
        ));

        Exercise? exercise = await exerciseDao.getExercise(exerciseGroup.exerciseId);
        if (muscleAmounts.containsKey(exercise!.muscle)) {
          muscleAmounts[exercise.muscle] = muscleAmounts[exercise.muscle]! + 1;
        } else {
          muscleAmounts[exercise.muscle] = 1;
        }
      }

      Map<Muscle, double> musclePercentages = {};
      for (Muscle muscle in muscleAmounts.keys) {
        musclePercentages[muscle] = muscleAmounts[muscle]! / exerciseGroups.length;
      }

      templates.add(Template(
        id: routine.id,
        type: routine.type,
        name: routine.name,
        sort: routine.sort,
        timestamp: routine.timestamp,
        note: routine.note,
        exerciseGroups: exerciseGroups,
        musclePercentages: musclePercentages,
        duration: duration,
        volume: volume,
      ));
    }

    return templates;
  }
}
