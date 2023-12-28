import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/database.dart';
import '../../../exercise/exercise.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  ProgramBloc({
    required this.exerciseDao,
    required this.programDao,
    required this.programFolderDao,
    required this.programTemplateDao,
    required this.programExerciseGroupDao,
  }) : super(const ProgramState()) {
    on<ProgramInitialize>(_initialize);
    on<ProgramBuild>(_build);
    on<ProgramDelete>(_delete);
  }

  final ExerciseDao exerciseDao;
  final ProgramDao programDao;
  final ProgramFolderDao programFolderDao;
  final ProgramTemplateDao programTemplateDao;
  final ProgramExerciseGroupDao programExerciseGroupDao;

  Future<void> _initialize(ProgramInitialize event, Emitter<ProgramState> emit) async {
    emit(state.copyWith(
      status: ProgramStatus.loaded,
      programs: await _fetchPrograms(),
    ));
  }

  Future<void> _build(ProgramBuild event, Emitter<ProgramState> emit) async {
    emit(state.copyWith(
      status: ProgramStatus.loading,
    ));

    int programId = await programDao.addProgram(event.program);

    for(int i = 1; i <= event.program.weeks; i++) {
      int programFolderId = await programFolderDao.addProgramFolder(
        ProgramFolder(
          order: i,
          programId: programId,
        ),
      );

      for(ProgramTemplate programTemplate in event.programTemplates) {
        int programTemplateId = await programTemplateDao.addProgramTemplate(
          ProgramTemplate(
            name: programTemplate.name,
            note: programTemplate.note,
            timestamp: DateTime.now().add(Duration(days: i*DateTime.daysPerWeek)),
            day: programTemplate.day,
            complete: false,
            folderId: programFolderId,
            type: RoutineType.template,
          ),
        );

        for(ExerciseBundle exerciseBundle in programTemplate.exerciseBundles) {
          int programExerciseGroupId = await programExerciseGroupDao.addProgramExerciseGroup(ProgramExerciseGroup(
            weightUnit: exerciseBundle.exerciseGroup.weightUnit,
            timer: exerciseBundle.exerciseGroup.timer,
            distanceUnit: exerciseBundle.exerciseGroup.distanceUnit,
            barId: exerciseBundle.exerciseGroup.barId,
            exerciseId: exerciseBundle.exerciseGroup.exerciseId,
            programTemplateId: programTemplateId,
          ));

         /* for(ExerciseSet exerciseSet in exerciseBundle.exerciseSets) {
            int templateExerciseSetId = await templateExerciseSetDao.addTemplateExerciseSet(TemplateExerciseSet(
              checked: exerciseSet.checked,
              type: exerciseSet.type,
              exerciseGroupId: templateExerciseGroupId,
              templateId: programTemplateId,
            ));

            for(ExerciseSetData exerciseSetData in exerciseSet.data) {
              await templateExerciseSetDataDao.addTemplateExerciseSetData(TemplateExerciseSetData(
                value: exerciseSetData.value,
                fieldType: exerciseSetData.fieldType,
                exerciseSetId: templateExerciseSetId,
              ));
            }
          }*/
        }
      }
    }
    
    emit(state.copyWith(
      status: ProgramStatus.loaded,
      programs: await _fetchPrograms(),
    ));
  }

  Future<void> _delete(ProgramDelete event, Emitter<ProgramState> emit) async {
    emit(state.copyWith(
      status: ProgramStatus.loading,
    ));

    await programDao.deleteProgram(event.program);

    emit(state.copyWith(
      status: ProgramStatus.loaded,
      programs: await _fetchPrograms(),
    ));
  }

  Future<List<Program>> _fetchPrograms() async {
    List<Program> programs = [];

    for(Program program in await programDao.getPrograms()) {
      List<ProgramFolder> programFolders = [];
      
      for(ProgramFolder programFolder in await programFolderDao.getProgramFoldersByProgramId(program.id!)) {
        List<ProgramTemplate> programTemplates = [];

        for(ProgramTemplate programTemplate in await programTemplateDao.getProgramTemplatesByFolderId(programFolder.id!)) {
          List<ExerciseBundle> exerciseBundles = [];

          for(ProgramExerciseGroup programExerciseGroup in await programExerciseGroupDao.getProgramExerciseGroupsByProgramTemplateId(programTemplate.id!)){
            Exercise? exercise = await exerciseDao.get(programExerciseGroup.exerciseId);

            /*exerciseBundles.add(ExerciseBundle(
              exercise: exercise!,
              exerciseGroup: programExerciseGroup,
              exerciseSets: [],
              barId: programExerciseGroup.barId,
            ));*/
          }

          programTemplates.add(programTemplate.copyWith(exerciseBundles: exerciseBundles));
        }

        programFolders.add(programFolder.copyWith(templates: programTemplates));
      }

      programs.add(program.copyWith(folders: programFolders));
    }

    return programs;
  }
}
