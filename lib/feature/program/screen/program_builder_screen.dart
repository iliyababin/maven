import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../exercise/screen/add_exercise_screen.dart';
import '../model/exercise_increment.dart';
import '../widget/exercise_increment_widget.dart';

class ProgramBuilderScreen extends StatefulWidget {
  const ProgramBuilderScreen({Key? key}) : super(key: key);

  @override
  State<ProgramBuilderScreen> createState() => _ProgramBuilderScreenState();
}

class _ProgramBuilderScreenState extends State<ProgramBuilderScreen> {
  final TextEditingController nameController = TextEditingController(text: 'My Program');
  final TextEditingController descriptionController = TextEditingController(text: 'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Orci a scelerisque purus semper eget duis at tellus.');

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
              SliverList(
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
              ),
              title('Exercises'),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 0,
                  (context, index) {
                    return Container();
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
