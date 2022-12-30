import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/common/theme/app_themes.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/widget/active_exercise_set_widget.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder(
          future: DatabaseHelper.instance.getExercise(widget.activeExerciseGroup.exerciseId),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return const Text("cant get exercises");
            Exercise exercise = snapshot.data!;
            return Row(
              children: [
                SizedBox(width: 10,),
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
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 35,
                  width: 65,
                  child: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          height: 30,
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 15,
                                color: colors(context).accentTextColor,
                              ),
                              const SizedBox(width: 5,),
                              Text(
                                'Auto Rest Timer',
                                style: TextStyle(
                                  color: colors(context).primaryTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                          onTap: (){

                          },
                        ),
                        PopupMenuItem(
                          height: 30,
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 15,
                                color: colors(context).errorColor,
                              ),
                              const SizedBox(width: 5,),
                              Text(
                                'Remove Exercise',
                                style: TextStyle(
                                  color: colors(context).errorColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            DatabaseHelper.instance.deleteActiveExerciseGroup(widget.activeExerciseGroup.activeExerciseGroupId!);
                            setState(() {

                            });
                          },
                        ),
                      ];
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    offset: Offset.fromDirection(2, 30),
                    color: colors(context).popupMenuBackgroundColor,
                    child: Icon(
                      Icons.more_horiz,
                      color: colors(context).accentTextColor,
                    ),
                  ),
                )
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
                child: Text(
                  "SET",
                  style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                  ),)

            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                alignment: Alignment.center,
                width: 90,
                child: Text(
                  "PREVIOUS",
                  style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                  ),
                )
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "WEIGHT",
                      style: TextStyle(
                        fontSize: 10,
                        color: colors(context).primaryTextColor
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
                  child: Text(
                    "REPS",
                    style: TextStyle(
                      fontSize: 10,
                      color: colors(context).primaryTextColor
                    ),
                  )
                )
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              width: 52,
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
                    setState(() {

                    });
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
          onPressed: (){
            DatabaseHelper.instance.addActiveExerciseSet(
              ActiveExerciseSet(
                activeExerciseGroupId: widget.activeExerciseGroup.activeExerciseGroupId!,
                activeWorkoutId: widget.activeExerciseGroup.activeWorkoutId
              )
            );
            setState(() {

            });
          },
          style: const ButtonStyle(),
          child: const Text("ADD SET")
        ),
      ],
    );
  }
}
