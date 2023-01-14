import 'package:Maven/common/model/active_exercise_group.dart';
import 'package:Maven/common/model/active_exercise_set.dart';
import 'package:Maven/common/model/exercise.dart';
import 'package:Maven/common/util/database_helper.dart';
import 'package:Maven/feature/workout/widget/active_exercise_set_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_popup_menu_button.dart';
import 'package:Maven/widget/m_popup_menu_item.dart';
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
          future: DBHelper.instance.getExercise(widget.activeExerciseGroup.exerciseId),
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
                          fontSize: 18,
                          color: mt(context).text.accentColor,
                          fontWeight: FontWeight.w900
                        )
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 52,
                  width: 52,
                  child: MPopupMenuButton(
                    iconColor: mt(context).icon.accentColor,
                    color: mt(context).popupMenu.backgroundColor,
                    children: [
                      MPopupMenuItem.build(
                        icon: Icon(
                          Icons.straighten,
                          size: 21,
                          color: mt(context).text.accentColor,
                        ),
                        text: 'Weight Unit',
                        textColor: mt(context).text.primaryColor,
                        onTap: (){}
                      ),
                      MPopupMenuItem.build(
                          icon: Icon(
                            Icons.timer_outlined,
                            size: 21,
                            color: mt(context).text.accentColor,
                          ),
                          text: 'Auto Rest Timer',
                          textColor: mt(context).text.primaryColor,
                          onTap: (){}
                      ),
                      MPopupMenuItem.build(
                        icon: Icon(
                          Icons.delete,
                          size: 21,
                          color: mt(context).icon.errorColor,
                        ),
                        text: 'Remove Exercise',
                        textColor: mt(context).text.errorColor,
                        onTap: (){}
                      ),
                    ]
                  )
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
                  fontSize: 11,
                  color: mt(context).text.primaryColor
                ),
              )
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
                  fontSize: 11,
                  color: mt(context).text.primaryColor
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
                    fontSize: 11,
                    color: mt(context).text.primaryColor,
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
                    fontSize: 11,
                    color: mt(context).text.primaryColor,
                  ),
                )
              )
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              width: 46,
              child: Text(""),
            ),
          ],
        ),
        FutureBuilder(
          future: DBHelper.instance.getActiveExerciseSetsByActiveExerciseGroupId(widget.activeExerciseGroup.activeExerciseGroupId!),
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
                    DBHelper.instance.deleteActiveExerciseSet(activeExerciseSet.activeExerciseSetId!);
                    setState(() {

                    });
                  },
                  background: Container(
                    color: Colors.redAccent,
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
            DBHelper.instance.addActiveExerciseSet(
              ActiveExerciseSet(
                activeExerciseGroupId: widget.activeExerciseGroup.activeExerciseGroupId!,
                workoutId: widget.activeExerciseGroup.workoutId
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
