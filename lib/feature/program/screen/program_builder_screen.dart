import 'package:Maven/common/dialog/show_bottom_sheet_dialog.dart';
import 'package:Maven/common/dialog/text_input_dialog.dart';
import 'package:Maven/common/util/general_utils.dart';
import 'package:Maven/feature/program/screen/day_selector_screen.dart';
import 'package:Maven/feature/template/screen/edit_template_screen.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/heading.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Program Builder',
          ),
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: const Icon(
                Icons.check_rounded,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(mt(context).padding.page),
          child: CustomScrollView(
            slivers: [
              const Heading(title: 'Basic', topPadding: false,),
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
                    leading: const Icon(
                      Icons.drive_file_rename_outline_rounded,
                    ),
                    borderRadius: 12,
                    borderColor: mt(context).color.secondary,
                    trailing: Text(
                      _name,
                      style: mt(context).textStyle.subtitle1,
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
                    leading: const Icon(
                      Icons.calendar_month_rounded,
                    ),
                    borderRadius: 12,
                    borderColor: mt(context).color.secondary,
                    trailing: Text(
                      _weeks.toString(),
                      style: mt(context).textStyle.subtitle1,
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
                    leading: const Icon(
                      Icons.view_day_rounded,
                    ),
                    borderRadius: 12,
                    borderColor: mt(context).color.secondary,
                    trailing: Text(
                      exerciseDays.getAbbreviations(),
                      style: mt(context).textStyle.subtitle1,
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
              const Heading(title: 'Templates',),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: exerciseDays.length,
                  (context, index) {
                    ExerciseDay exerciseDay = exerciseDays[index];

                    return MButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditTemplateScreen(
                          exerciseBundles: exerciseDay.exerciseBundles,
                          onSubmit: (value) {
                            setState(() {
                              exerciseDays[index].exerciseBundles = value;
                            });
                            Navigator.pop(context);
                          },
                        ),));
                      },
                      expand: false,
                      mainAxisAlignment: MainAxisAlignment.start,
                      borderColor: mt(context).color.secondary,
                      borderRadius: 12,
                      padding: const EdgeInsets.all(16),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              capitalize(exerciseDay.day.name),
                              style: mt(context).textStyle.heading3,
                            ),
                            const SizedBox(height: 4,),
                            Text(
                              '${exerciseDay.exerciseBundles.length} exercises',
                              style: mt(context).textStyle.subtitle2,
                            ),
                            const SizedBox(height: 6,),
                            Expanded(
                              child: ListView(
                                children: exerciseDay.exerciseBundles.map((e) => Text(
                                  '\u2022 ${e.exercise.name}',
                                  style: mt(context).textStyle.body1,
                                  maxLines: 1,
                                )).toList(),
                              ),
                            )
                          ],
                        ),
                      )
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