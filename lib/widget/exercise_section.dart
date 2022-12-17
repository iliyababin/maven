
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maven/data/app_themes.dart';
import 'package:maven/widget/set_row.dart';
import 'package:observable_ish/observable_ish.dart';
import 'dart:developer' as devl;

import '../data/data.dart';
import '../model/exercise_group.dart';
import '../model/exercise_set.dart';

class ExerciseSection extends StatefulWidget {
  final ExerciseGroup exerciseGroup;

  const ExerciseSection({Key? key, required this.exerciseGroup}) : super(key: key);

  @override
  State<ExerciseSection> createState() => _ExerciseSectionState();
}

class _ExerciseSectionState extends State<ExerciseSection> {

  List<ExerciseSet> exerciseSets = List.empty(growable: true);
  List<SetRow> setRows = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    exerciseSets = getExerciseSetsByExerciseGroupId(widget.exerciseGroup.exerciseGroupId).toList();
    convertSetRows();
  }


  void addSetRow(){
    exerciseSets.add(
      ExerciseSet(
        exerciseSetId: "100",
        weight: exerciseSets.last.weight,
        reps: exerciseSets.last.reps,
        exerciseGroupId: exerciseSets.last.exerciseGroupId
      )
    );
    convertSetRows();
  }

  void convertSetRows() {
    List<SetRow> tempSetRows = List.empty(growable: true);

    for (var index = 1; index < exerciseSets.length+1; ++index) {
      tempSetRows.add(SetRow(
        exerciseSet: exerciseSets.elementAt(index-1),
        index: index,
        onExerciseSetChanged: (exerciseSet) {

        },
      ));
    }
    setState(() {
      setRows = tempSetRows;
    });
  }


  @override
  Widget build(BuildContext context) {

    devl.log(exerciseSets.length.toString());


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      getExercise(widget.exerciseGroup.exerciseId).name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: colors(context).accentTextColor,
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context) =>
                  [
                    const PopupMenuItem(
                        child: ListTile(
                          visualDensity: VisualDensity.compact,
                          title: Text("Add note"),
                          textColor: Colors.white,
                        )
                    ),
                    const PopupMenuItem(
                        child: ListTile(
                          visualDensity: VisualDensity.compact,
                          title: Text("Remove exercise"),
                          textColor: Colors.red,
                        )
                    )
                  ],
                  icon: Icon(Icons.more_vert, color: Colors.blue,),
                  color: Color(0xff20232a),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 44,
              alignment: Alignment.center,
              child: Text(
                "SET",
                style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                ),
              ),
            ),
            Container(
              width: 80,
              alignment: Alignment.center,
              child: Text(
                "PREVIOUS",
                style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                ),
              ),
            ),
            Container(
              width: 80,
              alignment: Alignment.center,
              child: Text(
                "LBS",
                style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                ),
              ),
            ),
            Container(
              width: 80,
              alignment: Alignment.center,
              child: Text(
                "REPS",
                style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                "",
                style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: exerciseSets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final exerciseSet = exerciseSets[index];
            return Dismissible(
                background: Container(
                  color: colors(context).errorColor,
                  child: Container(
                    padding: EdgeInsetsDirectional.only(end: 8),
                    alignment: FractionalOffset.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: colors(context).backgroundColor,
                    ),
                  ),
                ),
                direction: DismissDirection.endToStart,
                key: Key(exerciseSet.exerciseSetId),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    exerciseSets.removeAt(index);
                  });
                },
                child: SetRow(
                  exerciseSet: exerciseSets.elementAt(index),
                  index: index,
                  onExerciseSetChanged: (exerciseSet) {
                  },
                )
            );
          },
        ),
        TextButton(
            onPressed: () {
              addSetRow();
            },
            child: Text(
              "ADD SET",
              style: TextStyle(
                  color: colors(context).accentTextColor
              ),
            )
        ),
      ],
    );
  }
}