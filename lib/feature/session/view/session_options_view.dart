
import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';
import '../session.dart';

showSessionOptionsView(BuildContext context, Session session) {
  showBottomSheetDialog(
    context: context,
    child: ListDialog(
      children: [
        ListTile(
          onTap: () {

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

          },
          leading: Icon(
            Icons.library_add_outlined,
          ),
          title: Text(
            'Create Template',
          ),
        ),
        ListTile(
          onTap: () {

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