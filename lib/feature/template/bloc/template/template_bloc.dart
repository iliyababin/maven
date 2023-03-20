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
    on<TemplateCreate>(_templateCreate);
    on<TemplateReorder>(_templateReorder);
    on<TemplateDelete>(_templateDelete);
    on<TemplateMoveToFolder>(_templateMoveToFolder);

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

  Future<void> _templateStreamUpdateTemplates(TemplateStreamUpdateTemplates event, emit) async {
    emit(state.copyWith(templates: () => event.templates));
  }

  Future<void> _templateStreamUpdateTemplateFolders(TemplateStreamUpdateTemplateFolders event, emit) async {
    emit(state.copyWith(templateFolders: () => event.templateFolders));
  }

  Future<void> _templateInitialize(TemplateInitialize event, Emitter emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loaded));
  }

  Future<void> _templateCreate(TemplateCreate event, emit) async {
    List<TemplateFolder> templateFolders = await templateFolderDao.getTemplateFolders();

    if(templateFolders.isEmpty) {
      TemplateFolder templateFolder = const TemplateFolder(
        name: 'Workouts',
        expanded: 1,
      );
      int templateFolderId = await templateFolderDao.addTemplateFolder(templateFolder);
      TemplateFolder? addedTemplateFolder = await templateFolderDao.getTemplateFolder(templateFolderId);
      templateFolders.add(addedTemplateFolder!);
    }

    int templateFolderId = templateFolders.first.templateFolderId!;

    int templateId = await templateDao.addTemplate(Template(name: event.name, templateFolderId: templateFolderId));

    for (ExerciseBlock exerciseBlock in event.exerciseBlocks) {
      int exerciseGroupId = await templateExerciseGroupDao.addTemplateExerciseGroup(
        TemplateExerciseGroup(
          exerciseId: exerciseBlock.exercise.exerciseId,
          templateId: templateId,
          barId: exerciseBlock.exerciseGroup.barId
        )
      );
      for (var exerciseSet in exerciseBlock.exerciseSets) {
        await templateExerciseSetDao.addTemplateExerciseSet(
          TemplateExerciseSet(
            templateId: templateId,
            templateExerciseGroupId: exerciseGroupId,
            option1: exerciseSet.option1,
            option2: exerciseSet.option2,
          ),
        );
      }
    }

    emit(state.copyWith(status: () => TemplateStatus.loaded));
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

  Future<void> _templateDelete(TemplateDelete event, emit) async {
    await templateExerciseSetDao.deleteExerciseSetsByTemplateId(event.template.templateId!);
    await templateExerciseGroupDao.deleteTemplateExerciseGroupsByTemplateId(event.template.templateId!);
    await templateDao.deleteTemplate(event.template);

    emit(state.copyWith(status: () => TemplateStatus.delete));
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

    emit(state.copyWith(status: () => TemplateStatus.delete));
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
    await templateFolderDao.addTemplateFolder(
      TemplateFolder(
        name: event.name,
        expanded: 1,
        sortOrder: (await templateFolderDao.getHighestTemplateFolderSortOrder() ?? 0) + 1,
      ),
    );
    emit(state.copyWith(status: () => TemplateStatus.add));
  }

  Future<void> _templateFolderUpdate(event, emit) async {
    await templateFolderDao.updateTemplateFolder(event.templateFolder);
    emit(state.copyWith(status: () => TemplateStatus.update));
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

