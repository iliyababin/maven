import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/common.dart';
import 'package:maven/feature/exercise/exercise.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';

class ExerciseAddScreen extends StatefulWidget {
  const ExerciseAddScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseAddScreen> createState() => _ExerciseAddScreenState();
}

class _ExerciseAddScreenState extends State<ExerciseAddScreen> {
  late Exercise exercise;

  @override
  void initState() {
    exercise = const Exercise.empty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add',
        ),
        actions: [
          IconButton(
            onPressed: exercise.name.isEmpty ? null : () {
              Navigator.pop(context);
              context.read<ExerciseBloc>().add(ExerciseAdd(
                    exercise: exercise,
                  ));
            },
            icon: Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: T(context).space.large,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: T(context).space.medium,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(
                  T(context).space.large,
                ),
                decoration: BoxDecoration(
                  color: T(context).color.surface,
                  borderRadius: BorderRadiusDirectional.circular(T(context).space.large),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          exercise = exercise.copyWith(name: value);
                        });
                      },
                      initialValue: exercise.name,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Name',
                      ),
                      style: T(context).textStyle.headingMedium,
                    ),
                  ],
                ),
              ),
            ),
            const Heading(
              title: 'Details',
            ),
            SliverToBoxAdapter(
              child: ExerciseEditWidget(
                exercise: exercise,
                onModify: (value) {
                  setState(() {
                    exercise = value;
                  });
                },
                typesEnabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
