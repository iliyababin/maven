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

    on<TemplateStreamUpdateTemplates>(_templateStreamUpdateTemplates);

    on<TemplateInitialize>(_templateInitialize);
    on<TemplateCreate>(_templateCreate);
    on<TemplateReorder>(_templateReorder);
    on<TemplateDelete>(_templateDelete);
    on<TemplateMoveToFolder>(_templateMoveToFolder);

  }

  final TemplateDao templateDao;
  final TemplateFolderDao templateFolderDao;
  final TemplateExerciseGroupDao templateExerciseGroupDao;
  final TemplateExerciseSetDao templateExerciseSetDao;

  Future<void> _templateStreamUpdateTemplates(TemplateStreamUpdateTemplates event, emit) async {
    emit(state.copyWith(templates: () => event.templates));
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

  Future<void> _templateMoveToFolder(TemplateMoveToFolder event, emit) async {
    final oldFolderId = event.templateFolders[event.oldTemplateFolderIndex].templateFolderId;
    final newFolderId = event.templateFolders[event.newTemplateFolderIndex].templateFolderId;
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
}

