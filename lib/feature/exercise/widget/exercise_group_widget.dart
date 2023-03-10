import 'package:flutter/material.dart';

import '../../../../theme/m_themes.dart';
import '../../../../widget/m_popup_menu_button.dart';
import '../../../../widget/m_popup_menu_item.dart';
import '../../../common/widget/m_button.dart';
import '../../workout/widget/active_exercise_row.dart';
import '../dto/exercise_set.dart';
import '../model/exercise.dart';
import 'exercise_set_widget.dart';

class ExerciseGroupWidget extends StatefulWidget {

  const ExerciseGroupWidget({super.key,
    required this.exercise,
    required this.exerciseSets,
    required this.onExerciseSetAdd,
    required this.onExerciseSetUpdate,
    required this.onExerciseSetDelete,
    this.checkboxEnabled = false,
    this.hintsEnabled = false,
  });

  final Exercise exercise;

  final List<ExerciseSet> exerciseSets;

  final VoidCallback onExerciseSetAdd;
  final ValueChanged<ExerciseSet> onExerciseSetUpdate;
  final ValueChanged<ExerciseSet> onExerciseSetDelete;

  final bool checkboxEnabled;
  final bool hintsEnabled;

  @override
  State<ExerciseGroupWidget> createState() => _ExerciseGroupWidgetState();
}

class _ExerciseGroupWidgetState extends State<ExerciseGroupWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Row(
          children: [

            SizedBox(width: 8),
            MButton(
              onPressed: (){},
              width: 40,
              height: 40,
              leading: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 26,
                color: mt(context).icon.accentColor,
              ),
            ),

            MButton(
              onPressed: () {

              },
              splashColor: mt(context).accentColor.withAlpha(50),
              mainAxisAlignment: MainAxisAlignment.start,
              height: 40,
              leading: SizedBox(width: 6),
              child: Text(
                widget.exercise.name,
                style: TextStyle(
                  fontSize: 18,
                  color: mt(context).text.accentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(
                height: 40,
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
        ),

        ActiveExerciseRow.build(
            set: Text(
              "SET",
              style: TextStyle(
                  fontSize: 13,
                  color: mt(context).text.primaryColor
              ),
            ),
            previous: Text(
              "PREVIOUS",
              style: TextStyle(
                  fontSize: 13,
                  color: mt(context).text.primaryColor
              ),
            ),
            option1: Text(
              widget.exercise.exerciseType.exerciseTypeOption1.value,
              style: TextStyle(
                fontSize: 13,
                color: mt(context).text.primaryColor,
              ),
            ),
            option2: widget.exercise.exerciseType.exerciseTypeOption2 != null ? Text(
              widget.exercise.exerciseType.exerciseTypeOption2!.value,
              style: TextStyle(
                fontSize: 13,
                color: mt(context).text.primaryColor,
              ),
            ) : null,
            checkbox: widget.checkboxEnabled ? Container( alignment: Alignment.center, child: Text(''),) : null
        ),

        const SizedBox(height: 3),

        ListView.builder(
          itemCount: widget.exerciseSets.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) => widget.onExerciseSetDelete(widget.exerciseSets[index]),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
              ),
              child: ExerciseSetWidget(
                index: index + 1,
                exercise: widget.exercise,
                exerciseSet: widget.exerciseSets[index],
                onExerciseSetUpdate: (value) => widget.onExerciseSetUpdate(value),
                checkboxEnabled: widget.checkboxEnabled,
                hintsEnabled: widget.hintsEnabled,
              ),
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: MButton(
            onPressed: () => widget.onExerciseSetAdd(),
            expand: false,
            leading: Icon(
              Icons.add_rounded,
              size: 24,
              color: mt(context).icon.accentColor,
            ),
            child: Text(
              'Add Set',
              style: TextStyle(
                color: mt(context).text.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

      ],
    );
  }

}
