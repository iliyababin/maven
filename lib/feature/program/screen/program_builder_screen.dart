import 'package:Maven/common/util/general_utils.dart';
import 'package:Maven/feature/program/screen/day_selector_screen.dart';
import 'package:Maven/feature/program/widget/folder_widget.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/m_button.dart';
import '../../exercise/screen/add_exercise_screen.dart';
import '../model/day.dart';
import '../model/exercise_day.dart';
import '../model/exercise_increment.dart';
import '../widget/exercise_increment_widget.dart';

class ProgramBuilderScreen extends StatefulWidget {
  const ProgramBuilderScreen({Key? key}) : super(key: key);

  @override
  State<ProgramBuilderScreen> createState() => _ProgramBuilderScreenState();
}

class _ProgramBuilderScreenState extends State<ProgramBuilderScreen> {
  int _weeks = 10;

  List<ExerciseDay> exerciseDays = [
    const ExerciseDay(day: Day.monday, exercises: []),
    const ExerciseDay(day: Day.wednesday, exercises: []),
    const ExerciseDay(day: Day.friday, exercises: []),
  ];
  List<ExerciseIncrement> exerciseIncrements = [];

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
                    child: Text(
                      'Weeks',
                      style: TextStyle(
                        color: mt(context).text.primaryColor,
                      ),
                    ),
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
                    child: Text(
                      'Days',
                      style: TextStyle(
                        color: mt(context).text.primaryColor,
                      ),
                    ),
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
              exerciseDays.isNotEmpty ? title('Exercises') : const SliverToBoxAdapter(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: exerciseDays.length,
                  (context, index) {
                    ExerciseDay exerciseDay = exerciseDays[index];
                    
                    return Container(
                      margin: EdgeInsetsDirectional.only(bottom: exerciseDays.length == index+1 ? 0: 12),
                      child: FolderWidget(
                        title: capitalize(exerciseDay.day.name),
                        subtitle: 'exercises',
                        children: exerciseDay.exercises.map((e) => Text(e.name, style: TextStyle(color: mt(context).text.primaryColor),)).toList(),
                      ),
                    );
                    
                    return Text(
                      capitalize(exerciseDay.day.name),
                      style: TextStyle(
                        color: mt(context).text.primaryColor,
                      ),
                    );
                  },
                ),
              ),
              title('Auto-Increment'),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: exerciseIncrements.length + 1,
                  (BuildContext context, int index) {
                    if(index == exerciseIncrements.length) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExerciseScreen())).then((value) {
                            setState(() {
                              exerciseIncrements.add(ExerciseIncrement(
                                exercise: value,
                                incrementAmount: 5,
                              ));
                            });
                          });
                        },
                        child: Container(
                          padding: const EdgeInsetsDirectional.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(15),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add_rounded,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    }

                    return ExerciseIncrementWidget(
                      exerciseIncrement: exerciseIncrements[index],
                      onExerciseIncrementChanged: (value) {
                        setState(() {
                          exerciseIncrements[index] = value;
                        });
                      }
                    );
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
