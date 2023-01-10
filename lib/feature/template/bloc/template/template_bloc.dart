import 'dart:developer';

import 'package:Maven/common/model/exercise_group.dart';
import 'package:Maven/common/model/exercise_set.dart';
import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/template/model/exercise_block.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc() : super(const TemplateState()) {

    ///
    /// Initialize
    ///

    on<InitializeTemplateBloc>((event, emit) async {
      emit(state.copyWith(status: () => TemplateStatus.loading));

      await Future.delayed(Duration(seconds: 2));

      List<Template> templates = await DBHelper.instance.getTemplates();
      List<TemplateFolder> templateFolders = await DBHelper.instance.getTemplateFolders();

      emit(state.copyWith(
          templates: () => templates,
          templateFolders: () => templateFolders,
          status: () => TemplateStatus.success
      ));
    });

    ///
    /// Template
    ///

    on<AddTemplate>((event, emit) async {
      log("trying to add template");
      if(state.status == TemplateStatus.success) {
        log("Iin");
        emit(state.copyWith(status: () => TemplateStatus.loading));

        int templateId = await DBHelper.instance.addTemplate(event.template);

        for (var exerciseBlock in event.exerciseBlocks) {
          int exerciseGroupId = await DBHelper.instance.addExerciseGroup(
            ExerciseGroup(
                exerciseId: exerciseBlock.exercise.exerciseId,
                templateId: templateId
            )
          );
          for (var tempExerciseSet in exerciseBlock.sets) {
            DBHelper.instance.addExerciseSet(
              ExerciseSet(
                  exerciseGroupId: exerciseGroupId,
                  weight: tempExerciseSet.weight,
                  reps: tempExerciseSet.reps,
                  templateId: templateId
              )
            );
          }
        }

        emit(state.copyWith(status: () => TemplateStatus.added));

        List<Template> templates = await DBHelper.instance.getTemplates();
        emit(state.copyWith(
            templates: () => templates,
            status: () => TemplateStatus.success
        ));
        log("Added Template: ${templateId}");
      } else {
        log("didnt add template");
      }
    });

    on<ReorderTemplates>((event, emit) async {
      emit(state.copyWith(status: () => TemplateStatus.reordering));

      List<Template> templates = event.templates;

      // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
      for (int i = 0; i < templates.length; i++) {
        Template template = templates[i];
        template.sortOrder = i;
        int test = await DBHelper.instance.updateTemplate(template);
      }

      emit(state.copyWith(
          templates: () => templates,
          status: () => TemplateStatus.success
      ));
    });

    ///
    /// TemplateFolder
    ///

    on<AddTemplateFolder>((event, emit) async {
      emit(state.copyWith(status: () => TemplateStatus.loading));

      await DBHelper.instance.addTemplateFolder(event.templateFolder);

      List<TemplateFolder> templateFolders = await DBHelper.instance.getTemplateFolders();

      emit(state.copyWith(
          templateFolders: () => templateFolders,
          status: () => TemplateStatus.success
      ));
    });

    on<UpdateTemplateFolder>((event, emit) async {
      await DBHelper.instance.updateTemplateFolder(event.templateFolder);

      List<TemplateFolder> templateFolders = await DBHelper.instance.getTemplateFolders();

      emit(state.copyWith(
          templateFolders: () => templateFolders,
          status: () => TemplateStatus.success
      ));
    });

    on<ReorderTemplateFolders>((event, emit) async {
      emit(state.copyWith(status: () => TemplateStatus.reordering));

      List<TemplateFolder> templateFolders = event.templateFolders;

      // TODO: Need better algo, this updates every row, maybe Stern-Brocot technique?
      for (int i = 0; i < templateFolders.length; i++) {
        TemplateFolder templateFolder = templateFolders[i];
        templateFolder.sortOrder = i;
        int test = await DBHelper.instance.updateTemplateFolder(templateFolder);
      }

      emit(state.copyWith(
          templateFolders: () => templateFolders,
          status: () => TemplateStatus.success
      ));
    });
  }
}