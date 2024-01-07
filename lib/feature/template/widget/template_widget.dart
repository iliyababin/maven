import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../template.dart';

class TemplateWidget extends StatefulWidget {
  const TemplateWidget({
    Key? key,
    required this.template,
    required this.exercises,
  }) : super(key: key);

  final Template template;
  final List<Exercise> exercises;

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(T(context).shape.large),
          color: T(context).color.surface,
        ),
        padding: EdgeInsets.all(T(context).space.large),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                widget.template.routine.name,
                style: T(context).textStyle.titleLarge,
                maxLines: 2,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.template.exerciseList.getLength(),
                (context, index) {
                  final exerciseGroup = widget.template.exerciseList.getExerciseGroup(index);
                  return Text(
                    '\u2022 ${widget.exercises.firstWhere((exercise) => exercise.id == exerciseGroup.exerciseId).name}',
                    style: T(context).textStyle.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
