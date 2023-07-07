import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';
import '../template.dart';

showTemplateOptionsView(BuildContext context, Template template) {
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
                  routine: template,
                  exerciseGroups: template.exerciseGroups,
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
                    template: template,
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
}