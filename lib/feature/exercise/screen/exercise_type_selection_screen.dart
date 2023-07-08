import 'package:flutter/material.dart';
import 'package:maven/common/common.dart';
import 'package:maven/database/enum/enum.dart';

import '../../../theme/theme.dart';

class ExerciseTypeSelectionScreen extends StatefulWidget {
  const ExerciseTypeSelectionScreen({
    Key? key,
    this.exerciseTypes,
  }) : super(key: key);

  final List<ExerciseFieldType>? exerciseTypes;

  @override
  State<ExerciseTypeSelectionScreen> createState() => _ExerciseTypeSelectionScreenState();
}

class _ExerciseTypeSelectionScreenState extends State<ExerciseTypeSelectionScreen> {
  late final List<ExerciseFieldType> exerciseTypes;

  @override
  void initState() {
    exerciseTypes = List.from(widget.exerciseTypes ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchableSelectionScreen<ExerciseFieldType>(
      title: 'Types',
      items: ExerciseFieldType.values,
      actions: [
        IconButton(
          onPressed: () {
            if(exerciseTypes.length < 1 || exerciseTypes.length > 3) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'You must select between 1 and 3 types.',
                  ),
                ),
              );
              return;
            }
            Navigator.pop(context, exerciseTypes);
          },
          icon: Icon(
            Icons.check,
            color: exerciseTypes.length < 1 || exerciseTypes.length > 3 ? T(context).color.outlineVariant : null,
          ),
        ),
      ],
      itemBuilder: (context, item) {
        return ListTile(
          onTap: () {
            setState(() {
              if(!exerciseTypes.remove(item)) {
                exerciseTypes.add(item);
              }
            });
          },
          leading: CircleAvatar(
            child: Text(
              item.name[0],
            ),
          ),
          title: Text(item.name),
          tileColor: exerciseTypes.contains(item) ? T(context).color.primaryContainer : null,
          trailing: exerciseTypes.contains(item) ? const Icon(Icons.check) : null,
        );
      },
    );
  }
}
