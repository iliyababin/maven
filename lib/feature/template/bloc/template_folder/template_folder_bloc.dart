import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dao/template_dao.dart';
import '../../dao/template_exercise_group_dao.dart';
import '../../dao/template_exercise_set_dao.dart';
import '../../dao/template_folder_dao.dart';
import '../../model/template.dart';
import '../../model/template_folder.dart';

part 'template_folder_event.dart';
part 'template_folder_state.dart';

class TemplateFolderBloc extends Bloc<TemplateFolderEvent, TemplateFolderState> {
  TemplateFolderBloc({
    required this.templateDao,
    required this.templateFolderDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
  }) : super(const TemplateFolderState()) {
    on<TemplateFolderInitialize>(_templateFolderInitialize);

    on<TemplateStreamUpdateTemplateFolders>(_templateStreamUpdateTemplateFolders);

    on<TemplateFolderAdd>(_templateFolderAdd);
    on<TemplateFolderUpdate>(_templateFolderUpdate);
    on<TemplateFolderToggle>(_templateFolderToggle);
    on<TemplateFolderReorder>(_templateFolderReorder);
    on<TemplateFolderDelete>(_templateFolderDelete);
  }

  final TemplateDao templateDao;
  final TemplateFolderDao templateFolderDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  void _templateFolderInitialize(TemplateFolderInitialize event, emit) {
    templateFolderDao.getTemplateFoldersAsStream().listen((event) => add(TemplateStreamUpdateTemplateFolders(templateFolders: event)));
  }

  Future<void> _templateFolderAdd(TemplateFolderAdd event, emit) async {
    emit(state.copyWith(status: () => TemplateFolderStatus.loading));

    await templateFolderDao.addTemplateFolder(TemplateFolder(
      name: event.name,
      expanded: 1,
      sortOrder: (await templateFolderDao.getHighestTemplateFolderSortOrder() ?? 0) + 1,
    ),);

    emit(state.copyWith(status: () => TemplateFolderStatus.loaded));
  }

  Future<void> _templateFolderUpdate(event, emit) async {
    emit(state.copyWith(status: () => TemplateFolderStatus.loading));

    await templateFolderDao.updateTemplateFolder(event.templateFolder);

    emit(state.copyWith(status: () => TemplateFolderStatus.loaded));
  }

  Future<void> _templateFolderToggle(TemplateFolderToggle event, emit) async {
    await emit(state.copyWith(status: () => TemplateFolderStatus.toggle));

    await templateFolderDao.updateTemplateFolder(event.templateFolder);
  }

  Future<void> _templateFolderReorder(event, emit) async {
    List<TemplateFolder> templateFolders = event.templateFolders;
    // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
    for (int i = 0; i < templateFolders.length; i++) {
      TemplateFolder templateFolder = templateFolders[i];
      templateFolderDao.updateTemplateFolder(templateFolder.copyWith(sortOrder: i));
    }
  }

  Future<void> _templateFolderDelete(TemplateFolderDelete event, emit) async {
    List<Template> templates = await templateDao.getTemplatesByTemplateFolderId(event.templateFolder.templateFolderId!);

    for(Template template in templates) {
      int templateId = template.templateId!;
      await templateExerciseSetDao.deleteExerciseSetsByTemplateId(templateId);
      await templateExerciseGroupDao.deleteTemplateExerciseGroupsByTemplateId(templateId);
      await templateDao.deleteTemplate(template);
    }

    await templateFolderDao.deleteTemplateFolder(event.templateFolder);
  }

  Future<void> _templateStreamUpdateTemplateFolders(TemplateStreamUpdateTemplateFolders event, emit) async {
    emit(state.copyWith(templateFolders: () => event.templateFolders));
  }
}
