import 'package:Maven/common/util/general_utils.dart';
import 'package:Maven/common/widget/heading.dart';
import 'package:Maven/common/widget/titled_scaffold.dart';
import 'package:Maven/feature/template/widget/empty_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../complete/bloc/complete_bloc/complete_bloc.dart';
import '../../complete/model/complete_bundle.dart';
import '../../complete/model/complete_exercise_bundle.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Progress',
      body: Padding(
        padding: EdgeInsets.all(mt(context).padding.page),
        child: CustomScrollView(
          slivers: [
            Heading(title: 'History', topPadding: false,),
            BlocBuilder<CompleteBloc, CompleteState>(
              builder: (context, state) {
                if(state.status.isLoading) {
                  return SliverToBoxAdapter(child: Container(),);
                } else if(state.status.isLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.completeBundles.length,
                      (context, index) {
                        CompleteBundle completeBundle  = state.completeBundles[index];
                        return Padding(
                          padding: EdgeInsetsDirectional.only(bottom: index == state.completeBundles.length - 1 ? 0 : 12),
                          child: Material(
                            color: mt(context).color.background,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: mt(context).color.secondary,
                                  ),
                                ),
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      completeBundle.complete.name,
                                      style: mt(context).textStyle.heading2,
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      DateFormat.yMMMMEEEEd().format(completeBundle.complete.timestamp).toString(),
                                      style: mt(context).textStyle.subtitle2,
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: mt(context).color.secondary,
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          durationToTime(completeBundle.complete.duration),
                                          style: mt(context).textStyle.body1,
                                        ),
                                        SizedBox(width: 20,),
                                        Icon(
                                          Icons.monitor_weight,
                                          color: mt(context).color.secondary,
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          '10,000 lbs',
                                          style: mt(context).textStyle.body1,
                                        ),
                                        SizedBox(width: 20,),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.fitness_center,
                                              color: mt(context).color.secondary,
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              '${completeBundle.completeExerciseBundles.length}',
                                              style: mt(context).textStyle.body1,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 12,),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: mt(context).color.secondary,
                                    ),
                                    SizedBox(height: 12,),
                                    completeBundle.completeExerciseBundles.isNotEmpty ? ListView.builder(
                                      itemCount: completeBundle.completeExerciseBundles.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        CompleteExerciseBundle completeExerciseBundle = completeBundle.completeExerciseBundles[index];
                                        return Text(
                                          '${completeExerciseBundle.completeExerciseSets.length} x ${completeExerciseBundle.exercise.name}',
                                          style: mt(context).textStyle.subtitle1,
                                        );
                                      },
                                    ) : Text(
                                      'None',
                                      style: mt(context).textStyle.subtitle1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const EmptyWidget();
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
