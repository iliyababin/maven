import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dao/template_dao.dart';
import '../../dao/template_exercise_group_dao.dart';
import '../../dao/template_exercise_set_dao.dart';
import '../../dao/template_folder_dao.dart';
import '../../dto/exercise_block.dart';
import '../../model/template.dart';
import '../../model/template_exercise_group.dart';
import '../../model/template_exercise_set.dart';
import '../../model/template_folder.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {

  final TemplateDao templateDao;
  final TemplateFolderDao templateFolderDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  TemplateBloc({
    required this.templateDao,
    required this.templateFolderDao,
    required this.templateExerciseGroupDao,
    required this.templateExerciseSetDao,
  }) : super(const TemplateState()) {
    templateDao.getTemplatesAsStream().listen((event) => add(TemplateStreamUpdateTemplates(templates: event)));
    templateFolderDao.getTemplateFoldersAsStream().listen((event) => add(TemplateStreamUpdateTemplateFolders(templateFolders: event)));

    on<TemplateStreamUpdateTemplates>(_templateStreamUpdateTemplates);
    on<TemplateStreamUpdateTemplateFolders>(_templateStreamUpdateTemplateFolders);

    on<TemplateInitialize>(_templateInitialize);
    on<TemplateAdd>(_templateAdd);
    on<TemplateReorder>(_templateReorder);
    on<TemplateMoveToFolder>(_templateMoveToFolder);

    on<TemplateFolderAdd>(_templateFolderAdd);
    on<TemplateFolderUpdate>(_templateFolderUpdate);
    on<TemplateFolderToggle>(_templateFolderToggle);
    on<TemplateFolderReorder>(_templateFolderReorder);
  }

  Future<void> _templateStreamUpdateTemplates(TemplateStreamUpdateTemplates event, emit) async {
    emit(state.copyWith(templates: () => event.templates));
  }

  Future<void> _templateStreamUpdateTemplateFolders(TemplateStreamUpdateTemplateFolders event, emit) async {
    emit(state.copyWith(templateFolders: () => event.templateFolders));
  }

  Future<void> _templateInitialize(TemplateInitialize event, Emitter emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loaded));
  }

  Future<void> _templateAdd(TemplateAdd event, emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading));

    int templateId = await templateDao.addTemplate(event.template);

    for (var exerciseBlock in event.exerciseBlocks) {
      int exerciseGroupId = await templateExerciseGroupDao.addTemplateExerciseGroup(
          TemplateExerciseGroup(
              exerciseId: exerciseBlock.exercise.exerciseId,
              templateId: templateId));
      for (var tempExerciseSet in exerciseBlock.sets) {
        templateExerciseSetDao.addTemplateExerciseSet(TemplateExerciseSet(
            exerciseGroupId: exerciseGroupId,
            option1: tempExerciseSet.option1,
            option2: tempExerciseSet.option2 != null ? tempExerciseSet.option2 : null,
            templateId: templateId));
      }
    }

    emit(state.copyWith(status: () => TemplateStatus.add));
  }

  Future<void> _templateReorder(TemplateReorder event, emit) async {
    List<Template> templates = event.templates;
    // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
    for (int i = 0; i < templates.length; i++) {
      Template template = templates[i];
      templateDao.updateTemplate(template.copyWith(sortOrder: i));
    }
    state.copyWith(status: () => TemplateStatus.reorder);
  }

  Future<void> _templateMoveToFolder(TemplateMoveToFolder event, emit) async {
    final oldFolderId = state.templateFolders[event.oldTemplateFolderIndex].templateFolderId;
    final newFolderId = state.templateFolders[event.newTemplateFolderIndex].templateFolderId;
    final templatesInOldFolder = _getTemplatesInFolder(oldFolderId!);
    final templatesInNewFolder = _getTemplatesInFolder(newFolderId!);
    if (event.oldTemplateFolderIndex == event.newTemplateFolderIndex) {
      final removedTemplate = templatesInOldFolder.removeAt(event.oldTemplateIndex);
      templatesInOldFolder.insert(event.newTemplateIndex, removedTemplate);
      for (int i = 0; i < templatesInOldFolder.length; i++) {
        Template template = templatesInOldFolder[i];
        templateDao.updateTemplate(template.copyWith(sortOrder: i));
      }
    } else {
      final removedTemplate = templatesInOldFolder.removeAt(event.oldTemplateIndex);
      templatesInNewFolder.insert(event.newTemplateIndex, removedTemplate.copyWith(templateFolderId: newFolderId));
      for (int i = 0; i < templatesInNewFolder.length; i++) {
        Template template = templatesInNewFolder[i];
        templateDao.updateTemplate(template.copyWith(sortOrder: i));
      }
    }
    await emit(state.copyWith(status: () => TemplateStatus.reorder));
  }

  List<Template> _getTemplatesInFolder(int folderId) {
    return state.templates.where((template) => template.templateFolderId == folderId).toList();
  }

  Future<void> _templateFolderAdd(TemplateFolderAdd event, emit) async {
    int num = (await templateFolderDao.getHighestTemplateFolderSortOrder() ?? 0) + 1;
    TemplateFolder templateFolder = TemplateFolder(
      name: event.name,
      expanded: 1,
      sortOrder: num,
    );
    await templateFolderDao.addTemplateFolder(templateFolder);
    await emit(state.copyWith(status: () => TemplateStatus.add));
  }

  Future<void> _templateFolderUpdate(event, emit) async {
    await templateFolderDao.updateTemplateFolder(event.templateFolder);
  }

  Future<void> _templateFolderToggle(TemplateFolderToggle event, emit) async {
    await emit(state.copyWith(status: () => TemplateStatus.toggle));
    await templateFolderDao.updateTemplateFolder(event.templateFolder);
  }

  Future<void> _templateFolderReorder(event, emit) async {
    List<TemplateFolder> templateFolders = event.templateFolders;
    // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
    for (int i = 0; i < templateFolders.length; i++) {
      TemplateFolder templateFolder = templateFolders[i];
      templateFolderDao.updateTemplateFolder(templateFolder.copyWith(sortOrder: i));
    }
    await emit(state.copyWith(status: () => TemplateStatus.reorder));
  }
}

