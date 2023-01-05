import 'package:Maven/theme/app_themes.dart';
import 'package:Maven/widget/set_row.dart';
import 'package:flutter/material.dart';

import '../common/model/exercise.dart';
import '../common/model/exercise_set.dart';

class ExerciseSection extends StatefulWidget {
  final Exercise exercise;
  final bool active;

  const ExerciseSection({Key? key, required this.exercise, required this.active}) : super(key: key);

  @override
  State<ExerciseSection> createState() => _ExerciseSectionState();
}

class _ExerciseSectionState extends State<ExerciseSection> {

  List<ExerciseSet> sets = [
    //ExerciseSet(hintWeight: 0, hintReps: 0)
  ];

  @override
  Widget build(BuildContext context) {
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
                      widget.exercise.name,
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        child: ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Text("Add note"),
                      textColor: Colors.white,
                    )),
                    const PopupMenuItem(
                        child: ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Text("Remove exercise"),
                      textColor: Colors.red,
                    ))
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.blue,
                  ),
                  color: const Color(0xff20232a),
                )
              ],
            )
          ],
        ),
        Row(
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
              width: 93,
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
              width: 100,
              alignment: Alignment.center,
              child: Text(
                "REPS",
                style: TextStyle(
                    fontSize: 10,
                    color: colors(context).primaryTextColor
                ),
              ),
            ),
            if(widget.active) SizedBox(
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
          itemCount: sets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final set = sets[index];
            return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    sets.removeAt(index);
                  });
                },
                background: Container(
                  color: colors(context).errorColor,
                ),
                child: SetRow(
                    index: index,
                    active: false,
                    set: set,
                    onChanged: (newSet) {
                      print("hey");
                      sets[index] = newSet;
                    }));
          },
        ),
        TextButton(
            onPressed: () {
              print(sets.length);
              setState(() {
                //sets.add(ExerciseSet(hintWeight:  0, hintReps:  0));
              });
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