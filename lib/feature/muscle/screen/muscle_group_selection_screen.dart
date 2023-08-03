import 'package:flutter/material.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';

class MuscleGroupSelectionScreen extends StatelessWidget {
  const MuscleGroupSelectionScreen({
    Key? key,
    this.muscleGroup,
  }) : super(key: key);

  final MuscleGroup? muscleGroup;

  @override
  Widget build(BuildContext context) {
    return SearchableSelectionScreen<MuscleGroup>(
      title: 'Muscle Group',
      items: MuscleGroup.values,
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          onTap: () {
            Navigator.pop(context, item);
          },
          leading: CircleAvatar(
            child: Text(
              item.name[0],
            ),
          ),
          title: Text(
            item.name,
          ),
          trailing: muscleGroup == item ? const Icon(Icons.check) : null,
        );
      },
    );
  }
}
