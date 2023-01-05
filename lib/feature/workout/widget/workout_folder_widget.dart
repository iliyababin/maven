import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/feature/workout/widget/workout_card_widget.dart';
import 'package:Maven/theme/app_themes.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkoutFolderWidget extends StatefulWidget {

  final WorkoutFolder workoutFolder;
  final Iterable<Workout> workouts;

  WorkoutFolderWidget({Key? key,
    required this.workoutFolder,
    required this.workouts
  }) : super(key: key);

  @override
  State<WorkoutFolderWidget> createState() => _WorkoutFolderWidgetState();
}

class _WorkoutFolderWidgetState extends State<WorkoutFolderWidget> {
  final double borderRadius = 8;

  workoutCards(BuildContext context) => widget.workouts.map((workout) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: WorkoutCard(
        workout: workout,
        borderColor: colors(context).backgroundDarkColor,
        onTap: (){},
        primaryTextColor: colors(context).primaryTextColor,
        backgroundColor: colors(context).backgroundColor,
        accentColor: colors(context).accentTextColor,
      ),
    );
  }).toList();

  final ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: 1,
          color: colors(context).backgroundDarkColor,
        )
      ),
      child: Material(
        color: colors(context).backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: (){
            setState(() {
              if(!_expandableController.expanded) _expandableController.toggle();
            });
          },
          borderRadius: BorderRadius.circular(borderRadius),
          child: ExpandablePanel(
            controller: _expandableController,
            theme: ExpandableThemeData(
              iconColor: colors(context).primaryColor,
              iconPlacement: ExpandablePanelIconPlacement.right,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              iconPadding: EdgeInsets.fromLTRB(0, 8, 8, 0),
              inkWellBorderRadius: BorderRadius.circular(borderRadius),
              iconSize: 30,
              useInkWell: false
            ),
            header: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: const EdgeInsets.fromLTRB(12, 12, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.workoutFolder.name,
                    style: TextStyle(
                        color: colors(context).primaryTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  Container(
                    width: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child : Material(
                        color: Colors.transparent,
                        child : InkWell(
                          child : Padding(
                            padding : const EdgeInsets.all(5),
                            child : Icon(
                              Icons.more_horiz,
                              color: colors(context).primaryColor,
                            ),
                          ),
                          onTap : () {
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
            collapsed: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 18),
              child: Text(
                '${widget.workouts.length.toString()} workouts',
                style: TextStyle(
                  color: colors(context).primaryTextColor,
                  fontSize: 16
                ),
              ),
            ),
            expanded: widget.workouts.length > 0 ? Column(
              children: [
                Column(
                  children: workoutCards(context),
                ),
                SizedBox(height: 10,)
              ],
            ) : Center(
              child: Column(
                children: [
                  SizedBox(height: 12,),
                  Icon(
                    Icons.library_add,
                    color: colors(context).textFieldHintColor,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                    child: Text(
                      "This folder is empty. Click the '+' button to add some workouts.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors(context).unselectedItemColor
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
