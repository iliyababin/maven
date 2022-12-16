
import 'package:flutter/material.dart';
import 'package:maven/widgets/set_row.dart';

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
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      getExercise(widget.exerciseGroup.exerciseId).name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.blue,
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
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 44,
                  alignment: Alignment.center,
                  child: const Text(
                    "SET",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: const Text(
                    "PREVIOUS",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: const Text(
                    "LBS",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: const Text(
                    "REPS",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  child: const Text(
                    "",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: getSetRows(),
            )
          ],
        ),
        TextButton(
            onPressed: () {},
            child: Text("ADD SET", style: TextStyle(color: Colors.blue),)
        )
      ],
    );
  }

  List<SetRow> getSetRows() {
    List<ExerciseSet> exerciseSets = getExerciseSetsByExerciseGroupId(widget.exerciseGroup.exerciseGroupId).toList();
    List<SetRow> setTiles = List.empty(growable: true);
    for (var index = 1; index < exerciseSets.length+1; ++index) {
      setTiles.add(SetRow(exerciseSet: exerciseSets.elementAt(index-1), index: index));
    }
    return setTiles;
  }

  Widget getExerciseTiles(List<String> strings) {
    return new Row(children: strings.map((item) => new Text(item)).toList());
  }
}