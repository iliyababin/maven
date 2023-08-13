import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/template/view/template_options_view.dart';

import '../../../common/common.dart';
import '../../theme/theme.dart';
import '../../exercise/exercise.dart';
import '../template.dart';

class TemplateWidget extends StatefulWidget {
  const TemplateWidget({
    Key? key,
    required this.template,
  }) : super(key: key);

  final Template template;

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TemplateDetailScreen(
                  template: widget.template,
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(T(context).shape.large),
              color: T(context).color.surface,
            ),
            padding: EdgeInsets.all(T(context).space.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.template.name,
                  style: T(context).textStyle.titleLarge,
                  maxLines: 2,
                ),
                Expanded(
                  child: BlocBuilder<ExerciseBloc, ExerciseState>(
                    builder: (context, state) {
                      if (state.status.isLoaded) {
                        return ListView.builder(
                          itemCount: widget.template.exerciseGroups.length,
                          itemBuilder: (context, index) {
                            final exerciseGroup = widget.template.exerciseGroups[index];
                            return Text(
                              '\u2022 ${state.exercises.firstWhere((exercise) => exercise.id == exerciseGroup.exerciseId).name}',
                              style: T(context).textStyle.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: IconButton(
            onPressed: () {
              showBottomSheetDialog(
                context: context,
                child: ListDialog(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoutineEditScreen(
                              routine: widget.template,
                              exerciseGroups: widget.template.exerciseGroups,
                              onSubmit: (template, exerciseGroups) {
                                context.read<TemplateBloc>().add(
                                  TemplateUpdate(
                                    routine: template,
                                    exerciseGroups: exerciseGroups,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                      leading: const Icon(
                        Icons.edit_rounded,
                      ),
                      title: const Text(
                        'Edit',
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // TODO: Implement share
                      },
                      leading: const Icon(
                        Icons.share_rounded,
                      ),
                      title: const Text(
                        'Share',
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        showBottomSheetDialog(
                          context: context,
                          child: ConfirmationDialog(
                            title: 'Delete Template',
                            subtitle: 'This action cannot be undone.',
                            cancelButtonStyle: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(T(context).color.onBackground),
                            ),
                            confirmButtonStyle: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(T(context).color.error),
                              foregroundColor: MaterialStateProperty.all(T(context).color.onError),
                            ),
                            confirmText: 'Delete',
                            onSubmit: () {
                              context.read<TemplateBloc>().add(TemplateDelete(
                                template: widget.template,
                              ));
                            },
                          ),
                          onClose: () {},
                        );
                      },
                      leading: Icon(
                        Icons.delete_rounded,
                        color: T(context).color.error,
                      ),
                      title: Text(
                        'Delete',
                        style: TextStyle(
                          color: T(context).color.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.more_horiz,
            ),
          ),
        ),
      ],
    );
  }
}
