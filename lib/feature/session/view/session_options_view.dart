import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/routine/screen/routine_edit_screen.dart';

import '../../../common/common.dart';
import '../../theme/theme.dart';
import '../session.dart';

showSessionOptionsView(BuildContext context, Session session) {
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
                  routine: session.routine,
                  exerciseGroups: session.exerciseGroups,
                  onSubmit: (routine, exerciseGroups) {
                    Navigator.pop(context);
                    context.read<SessionBloc>().add(
                          SessionUpdate(
                            session: session.copyWith(
                              routine: routine,
                              exerciseGroups: exerciseGroups,
                            ),
                          ),
                        );

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
          onTap: () {},
          leading: Icon(
            Icons.library_add_outlined,
          ),
          title: Text(
            'Create Template',
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            context.read<SessionBloc>().add(
                  SessionDelete(
                    session: session,
                  ),
                );
          },
          leading: Icon(
            Icons.delete,
            color: T(context).color.error,
          ),
          title: Text(
            'Delete',
            style: TextStyle(
              color: T(context).color.error,
            ),
          ),
        )
      ],
    ),
  );
}
