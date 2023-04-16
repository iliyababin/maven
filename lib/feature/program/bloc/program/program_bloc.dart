import 'dart:async';

import 'package:Maven/common/util/general_utils.dart';
import 'package:Maven/feature/program/dao/program_dao.dart';
import 'package:Maven/feature/program/model/folder.dart';
import 'package:Maven/feature/template/dao/template_exercise_group_dao.dart';
import 'package:Maven/feature/template/model/template.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../template/dao/template_dao.dart';
import '../../../template/dao/template_exercise_set_dao.dart';
import '../../dao/folder_dao.dart';
import '../../dao/template_tracker_dao.dart';
import '../../model/exercise_day.dart';
import '../../model/program.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  ProgramBloc({
    required this.programDao,
    required this.folderDao,
    required this.templateDao,
    required this.templateTrackerDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
  }) : super(const ProgramState()) {
    on<ProgramInitialize>(_initialize);
    on<ProgramBuild>(_build);
    on<ProgramStream>(_stream);
  }

  final ProgramDao programDao;
  final FolderDao folderDao;
  final TemplateDao templateDao;
  final TemplateTrackerDao templateTrackerDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  FutureOr<void> _initialize(ProgramInitialize event, Emitter<ProgramState> emit) {
    emit(state.copyWith(status: () => ProgramStatus.loading,));

    programDao.getProgramsAsStream().listen((event) => add(ProgramStream(programs: event)));

    emit(state.copyWith(status: () => ProgramStatus.loaded,));
  }

  Future<void> _build(ProgramBuild event, Emitter<ProgramState> emit) async {
    emit(state.copyWith(status: () => ProgramStatus.loading,));

    // Create program
    int programId = await programDao.addProgram(event.program);

    for(int i = 1; i <= event.program.weeks; i++) {
      // Create folder
      int folderId = await folderDao.addFolder(Folder(
        name: 'Week ${i.toString()}',
        programId: programId,
      ));

      for(int j = 0; j < event.exerciseDays.length; j++) {
        ExerciseDay exerciseDay = event.exerciseDays[j];

        // Create template
        int templateId = await templateDao.addTemplate(Template(
          name: capitalize(exerciseDay.day.name),
          sortOrder: j + 1,
          folderId: folderId,
        ));
      }
    }

    emit(state.copyWith(status: () => ProgramStatus.loaded,));
  }

  Future<void> _stream(ProgramStream event, Emitter<ProgramState> emit) async {
    print(event.programs);
    emit(state.copyWith(programs: () => event.programs,));
  }
}
