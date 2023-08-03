import 'package:flutter/material.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';

class MuscleSelectionScreen extends StatelessWidget {
  const MuscleSelectionScreen({
    Key? key,
    this.muscle,
  }) : super(key: key);

  final Muscle? muscle;

  @override
  Widget build(BuildContext context) {
    return SearchableSelectionScreen<Muscle>(
      title: 'Muscle',
      items: Muscle.values,
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pop(item);
          },
          leading: CircleAvatar(
            child: Text(
              item.name[0],
            ),
          ),
          title: Text(
            item.name,
          ),
          trailing: muscle == item ? const Icon(Icons.check) : null,
        );
      },
    );
  }
}
