import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/data/app_themes.dart';
import 'package:Maven/feature/workout/widget/active_exercise_set_widget.dart';
import 'package:Maven/util/database_helper.dart';
import 'package:flutter/material.dart';

class ActiveExerciseGroupWidget extends StatefulWidget {
  const ActiveExerciseGroupWidget({Key? key, required this.activeExerciseGroup}) : super(key: key);

  final ActiveExerciseGroup activeExerciseGroup;

  @override
  State<ActiveExerciseGroupWidget> createState() => _ActiveExerciseGroupWidgetState();
}

class _ActiveExerciseGroupWidgetState extends State<ActiveExerciseGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
            future: DatabaseHelper.instance.getExercise(widget.activeExerciseGroup.exerciseId),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("cant get exercises");
              Exercise exercise = snapshot.data!;
              return Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {  },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          exercise.name,
                          style: TextStyle(
                            fontSize: 15,
                            color: colors(context).accentTextColor,
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
              const SizedBox(
                width: 10,
              ),
              Container(
                  alignment: Alignment.center,
                  width: 35,
                  child: const Text(
                    "SET",
                    style: TextStyle(
                        fontSize: 10
                    ),)

              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  alignment: Alignment.center,
                  width: 80,
                  child: const Text(
                    "PREVIOUS",
                    style: TextStyle(
                        fontSize: 10
                    ),
                  )
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "WEIGHT",
                        style: TextStyle(
                            fontSize: 10
                        ),
                      )
                  )
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "REPS",
                        style: TextStyle(
                            fontSize: 10
                        ),
                      )
                  )
              ),
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                width: 42,
                child: Text(""),
              ),
            ],
          ),
          FutureBuilder(
            future: DatabaseHelper.instance.getActiveExerciseSetsByActiveExerciseGroupId(widget.activeExerciseGroup.activeExerciseGroupId!),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("bruh");

              List<ActiveExerciseSet> activeExerciseSets = snapshot.data!;

              return ListView.builder(
                itemCount: activeExerciseSets.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  ActiveExerciseSet activeExerciseSet = activeExerciseSets[index];

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      DatabaseHelper.instance.deleteActiveExerciseSet(activeExerciseSet.activeExerciseSetId!);
                    },
                    background: Container(
                      color: colors(context).errorColor,
                    ),
                    child: ActiveExerciseSetWidget(
                      index: index,
                      activeExerciseSet: activeExerciseSet
                    ),
                  );
                },
              );
            },
          ),
          TextButton(
              onPressed: (){},
              child: Text("ADD SET")
          ),
        ],
      ),
    );
  }
}
