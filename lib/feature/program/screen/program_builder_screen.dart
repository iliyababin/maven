import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:Maven/common/dialog/text_input_dialog.dart';
import 'package:Maven/common/util/general_utils.dart';
import 'package:Maven/feature/program/screen/day_selector_screen.dart';
import 'package:Maven/feature/template/screen/edit_template_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/m_button.dart';
import '../model/day.dart';
import '../model/exercise_day.dart';

class ProgramBuilderScreen extends StatefulWidget {
  const ProgramBuilderScreen({Key? key}) : super(key: key);

  @override
  State<ProgramBuilderScreen> createState() => _ProgramBuilderScreenState();
}

class _ProgramBuilderScreenState extends State<ProgramBuilderScreen> {
  String _name = 'My Program';
  int _weeks = 10;

  List<ExerciseDay> exerciseDays = [
    ExerciseDay(day: Day.monday, exerciseBundles: []),
    ExerciseDay(day: Day.wednesday, exerciseBundles: []),
    ExerciseDay(day: Day.friday, exerciseBundles: []),
  ];

  SliverToBoxAdapter title(String title) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsetsDirectional.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          color: mt(context).text.primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Program Builder',
            style: TextStyle(
              color: mt(context).text.primaryColor
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.check_rounded,
                color: mt(context).icon.accentColor,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(mt(context).sidePadding),
          child: CustomScrollView(
            slivers: [
              title('Basic'),
              SliverList(
                delegate: SliverChildListDelegate([
                  MButton.tiled(
                    onPressed: (){
                      showBottomSheetDialog(
                        context: context,
                        child: TextInputDialog(
                          title: 'Name',
                          initialValue: _name,
                          keyboardType: TextInputType.name,
                          onValueSubmit: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                        ),
                        onClose: (){},
                      );
                    },
                    expand: false,
                    leading: Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: mt(context).icon.accentColor,
                    ),
                    borderRadius: 12,
                    borderColor: mt(context).borderColor,
                    trailing: Text(
                      _name,
                      style: TextStyle(
                        color: mt(context).text.secondaryColor,
                      ),
                    ),
                    title: 'Name',
                  ),
                  const SizedBox(height: 12,),
                  MButton.tiled(
                    onPressed: (){
                      showBottomSheetDialog(
                        context: context,
                        child: TextInputDialog(
                          title: 'Weeks',
                          initialValue: _weeks.toString(),
                          onValueSubmit: (value) {
                            setState(() {
                              _weeks = int.parse(value);
                            });
                          },
                        ),
                        onClose: (){},
                      );
                    },
                    expand: false,
                    leading: Icon(
                      Icons.calendar_month_rounded,
                      color: mt(context).icon.accentColor,
                    ),
                    borderRadius: 12,
                    borderColor: mt(context).borderColor,
                    trailing: Text(
                      _weeks.toString(),
                      style: TextStyle(
                        color: mt(context).text.secondaryColor,
                      ),
                    ),
                    title: 'Weeks',
                  ),
                  const SizedBox(height: 12,),
                  MButton.tiled(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DaySelectorScreen(
                        exerciseDays: exerciseDays,
                        onSubmit: (List<ExerciseDay> value) {
                          setState(() {
                            exerciseDays = value.sortDays();
                          });
                        },
                      )));
                    },
                    expand: false,
                    leading: Icon(
                      Icons.view_day_rounded,
                      color: mt(context).icon.accentColor,
                    ),
                    borderRadius: 12,
                    borderColor: mt(context).borderColor,
                    trailing: Text(
                      exerciseDays.getAbbreviations(),
                      style: TextStyle(
                        color: mt(context).text.secondaryColor,
                      ),
                    ),
                    title: 'Days',
                  ),
                ]),
              ),
              /*SliverList(
                delegate: SliverChildListDelegate([
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Program',
                    ),
                    style: TextStyle(
                      color: mt(context).text.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Program',
                    ),
                    style: TextStyle(
                      color: mt(context).text.secondaryColor,
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                ]),
              ),*/
              title('Templates'),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: exerciseDays.length,
                  (context, index) {
                    ExerciseDay exerciseDay = exerciseDays[index];

                    return Container(
                      margin: EdgeInsetsDirectional.only(bottom: exerciseDays.length == index+1 ? 0: 12),
                      child: MButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditTemplateScreen(
                            exerciseBundles: exerciseDay.exerciseBundles,
                            onSubmit: (value) {
                              setState(() {
                                exerciseDays[index].exerciseBundles = value;
                              });
                            },
                          ),));
                        },
                        expand: false,
                        mainAxisAlignment: MainAxisAlignment.start,
                        borderColor: mt(context).borderColor,
                        borderRadius: 12,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                capitalize(exerciseDay.day.name),
                                style: TextStyle(
                                  color: mt(context).text.primaryColor,
                                ),
                              ),
                              Text(
                                '${exerciseDay.exerciseBundles.length} exercises',
                                style: TextStyle(
                                  color: mt(context).text.secondaryColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
/*
 Navigator.push(context, MaterialPageRoute(builder: (context) => SelectExerciseScreen(
                            exercises: exercises,
                          ))).then((value) {
                            if(value == null) return;
                            setState(() {
                              exerciseIncrements.add(ExerciseIncrement(
                                exercise: value,
                                incrementAmount: 5,
                              ));
                            });
                          });*/