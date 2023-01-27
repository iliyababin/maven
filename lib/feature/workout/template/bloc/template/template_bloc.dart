import 'dart:async';

import 'package:Maven/common/model/exercise_group.dart';
import 'package:Maven/common/model/exercise_set.dart';
import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/exercise_block.dart';
import '../../repository/exercise_group_repository_impl.dart';
import '../../repository/exercise_set_repository_impl.dart';
import '../../repository/template_folder_repository_impl.dart';
import '../../repository/template_repository_impl.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  final TemplateRepositoryImpl templateRepository;
  final TemplateFolderRepositoryImpl templateFolderRepository;
  final ExerciseGroupRepositoryImpl exerciseGroupRepository;
  final ExerciseSetRepositoryImpl exerciseSetRepository;

  TemplateBloc({
    required this.templateRepository,
    required this.exerciseGroupRepository,
    required this.exerciseSetRepository,
    required this.templateFolderRepository,
  }) : super(const TemplateState()) {
    on<TemplateInitialize>(_templateInitialize);
    on<TemplateAdd>(_templateAdd);
    on<TemplateReorder>(_templateReorder);

    on<TemplateFolderAdd>(_templateFolderAdd);
    on<TemplateFolderUpdate>(_templateFolderUpdate);
    on<TemplateFolderReorder>(_templateFolderReorder);
  }

  Future<void> _templateInitialize(TemplateInitialize event, emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    List<Template> templates = await templateRepository.getTemplates();
    List<TemplateFolder> templateFolders = await templateFolderRepository.getTemplateFolders();

    emit(state.copyWith(
      status: () => TemplateStatus.success,
      templates: () => templates,
      templateFolders: () => templateFolders,
    ));
  }

  Future<void> _templateAdd(TemplateAdd event, emit) async {
    emit(state.copyWith(status: () => TemplateStatus.loading));

    int templateId = await templateRepository.addTemplate(event.template);

    for (var exerciseBlock in event.exerciseBlocks) {
      int exerciseGroupId = await exerciseGroupRepository.addExerciseGroup(
          ExerciseGroup(
              exerciseId: exerciseBlock.exercise.exerciseId,
              templateId: templateId));
      for (var tempExerciseSet in exerciseBlock.sets) {
        exerciseSetRepository.addExerciseSet(ExerciseSet(
            exerciseGroupId: exerciseGroupId,
            weight: tempExerciseSet.weight,
            reps: tempExerciseSet.reps,
            templateId: templateId));
      }
    }

    emit(state.copyWith(status: () => TemplateStatus.added));

    List<Template> templates = await templateRepository.getTemplates();

    emit(state.copyWith(
        templates: () => templates, status: () => TemplateStatus.success));
  }

  Future<void> _templateReorder(TemplateReorder event, emit) async {
    emit(
      state.copyWith(status: () => TemplateStatus.reordering),
    );

    List<Template> templates = event.templates;

    // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
    for (int i = 0; i < templates.length; i++) {
      Template template = templates[i];
      template.sortOrder = i;
      templateRepository.updateTemplate(template);
    }

    emit(state.copyWith(
      status: () => TemplateStatus.success,
      templates: () => templates,
    ));
  }

  Future<void> _templateFolderAdd(event, emit) async {
    emit(
      state.copyWith(status: () => TemplateStatus.loading),
    );

    await templateFolderRepository.addTemplateFolder(event.templateFolder);

    List<TemplateFolder> templateFolders =
        await templateFolderRepository.getTemplateFolders();

    emit(state.copyWith(
      status: () => TemplateStatus.success,
      templateFolders: () => templateFolders,
    ));
  }

  Future<void> _templateFolderUpdate(event, emit) async {
    await DBHelper.instance.updateTemplateFolder(event.templateFolder);

    List<TemplateFolder> templateFolders =
        await templateFolderRepository.getTemplateFolders();

    emit(state.copyWith(
      templateFolders: () => templateFolders,
      status: () => TemplateStatus.success,
    ));
  }

  Future<void> _templateFolderReorder(event, emit) async {
    emit(state.copyWith(
      status: () => TemplateStatus.reordering,
    ));

    List<TemplateFolder> templateFolders = event.templateFolders;

    // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
    for (int i = 0; i < templateFolders.length; i++) {
      TemplateFolder templateFolder = templateFolders[i];
      templateFolder.sortOrder = i;
      int test = await DBHelper.instance.updateTemplateFolder(templateFolder);
    }

    emit(state.copyWith(
      status: () => TemplateStatus.success,
      templateFolders: () => templateFolders,
    ));
  }
}
