import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../exercise.dart';

class ExerciseDetailView extends StatefulWidget {
  const ExerciseDetailView({
    super.key,
    required this.exercise,
    required this.onModify,
  });

  final Exercise exercise;
  final Function(Exercise exercise) onModify;

  @override
  State<ExerciseDetailView> createState() => _ExerciseDetailViewState();
}

class _ExerciseDetailViewState extends State<ExerciseDetailView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const Heading(
          title: 'Video',
          side: true,
          size: HeadingSize.medium,
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: T(context).space.large,
          ),
          sliver: SliverToBoxAdapter(
            child: Container(
              height: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.all(
                T(context).space.large,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: T(context).color.surface,
              ),
              child: Text(
                'Not Available \n \n Support us in making animations for this exercise on Github.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const Heading(
          title: 'Details',
          side: true,
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
          sliver: SliverToBoxAdapter(
            child: ExerciseEditWidget(
              exercise: widget.exercise,
              onModify: widget.onModify,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: T(context).space.large,
          ),
        )
      ],
    );
  }
}
