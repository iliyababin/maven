/*
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maven/database/dao/template_tracker_dao.dart';

import '../../../../database/TEST_ZONE/folder.dart';
import '../../../../database/TEST_ZONE/program.dart';
import '../../../../database/TEST_ZONE/template_tracker.dart';
import '../../../../database/dao/folder_dao.dart';
import '../../../../database/dao/program_dao.dart';
import '../../../../database/dao/template_dao.dart';
import '../../../../database/model/template.dart';

part 'program_detail_event.dart';
part 'program_detail_state.dart';

class ProgramDetailBloc extends Bloc<ProgramDetailEvent, ProgramDetailState> {
  ProgramDetailBloc({
    required this.programDao,
    required this.folderDao,
    required this.templateDao,
    required this.templateTrackerDao,
  }) : super(const ProgramDetailState()) {
    on<ProgramDetailInitialize>(_initialize);
    on<ProgramDetailLoad>(_load);
    on<ProgramDetailTemplateTrackerUpdate>(_templateTrackerUpdate);
  }

  final ProgramDao programDao;
  final FolderDao folderDao;
  final TemplateDao templateDao;
  final TemplateTrackerDao templateTrackerDao;

  Future<void> _initialize(ProgramDetailInitialize event, Emitter<ProgramDetailState> emit) async {
    emit(state.copyWith(status: () => ProgramDetailStatus.loading,));

    emit(state.copyWith(status: () => ProgramDetailStatus.loaded,));
  }

  Future<void> _load(ProgramDetailLoad event, Emitter<ProgramDetailState> emit) async {
    emit(state.copyWith(status: () => ProgramDetailStatus.loading,));

    Program? program = await programDao.getProgram(event.programId);

    if(program == null) {
      emit(state.copyWith(status: () => ProgramDetailStatus.error,));
      return;
    }

    List<Folder> folders = await folderDao.getFoldersByProgramId(program.programId!);

    for(int i = 0; i < folders.length; i++) {
      List<Template> templates = await templateDao.getTemplates();

      for (int j = 0; j < templates.length; j++) {
        TemplateTracker? templateTracker = await templateTrackerDao.getTemplateTrackerByTemplateId(templates[j].id!);
        //templates[j] = templates[j].copyWith(templateTracker: templateTracker);
      }

      folders[i] = folders[i].copyWith(templates: templates);
    }

    emit(state.copyWith(
      status: () => ProgramDetailStatus.loaded,
      program: () => program,
      folders: () => folders,
    ));
  }
  
  Future<void> _templateTrackerUpdate(ProgramDetailTemplateTrackerUpdate event, Emitter<ProgramDetailState> emit) async {
    await templateTrackerDao.updateTemplateTracker(event.templateTracker);
    emit(state.copyWith(
      folders: () => state.folders.map((folder) {
        return folder.copyWith(templates: folder.templates.map((template) {
          */
/*if(template.templateId == event.templateTracker.templateId) {
            return template.copyWith(templateTracker: event.templateTracker);
          }*//*

          return template;
        }).toList());
      }).toList(),
    ));
  }
}
*/
