import 'dart:async';

import 'package:Maven/common/dialog/bottom_sheet_dialog.dart';
import 'package:Maven/common/dialog/show_timer_picker_dialog.dart';
import 'package:Maven/feature/workout/common/dto/exercise_set.dart';
import 'package:Maven/feature/workout/common/widget/exercise_group_widget.dart';
import 'package:Maven/feature/workout/workout/service/workout_service.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/model/timed.dart';
import '../../../../common/util/general_utils.dart';
import '../../../../screen/add_exercise_screen.dart';
import '../../common/model/exercise.dart';
import '../bloc/active_workout/workout_bloc.dart';
import '../model/workout.dart';
import '../model/workout_exercise_group.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key,
    required this.isWorkoutActive,
    required this.workoutService
  }) : super(key: key);

  final Function(bool) isWorkoutActive;

  final WorkoutService workoutService;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin{
  Future<WorkoutDto?>? _workoutDto;

  Timer _timer = Timer(const Duration(seconds: 30), () { });
  double _timePercent = 0;
  String _timeFormatted = '';

  @override
  void initState() {
    super.initState();
    _workoutDto = fetchWorkoutDto();
  }

  Future<WorkoutDto?> fetchWorkoutDto() async {
    return await widget.workoutService.getWorkoutDto();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _workoutDto,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if(snapshot.data?.workout == null) {
          return Expanded(
            child: Center(
              child: Text(
                'There is no active workout.',
                style: TextStyle(
                  color: mt(context).text.primaryColor
                ),
              ),
            ),
          );
        }

        Workout workout = snapshot.data!.workout;
        List<WorkoutGroupDto> workoutGroupDtos = snapshot.data!.workoutGroupDtos;

        return Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                decoration: BoxDecoration(
                  color: mt(context).backgroundColor,
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          MFlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddExerciseScreen()),
                              ).then((value) async {
                                Exercise exercise = value;
                                int workoutExerciseGroupId = await widget.workoutService.addWorkoutExerciseGroup(workoutId: workout.workoutId!, exercise: exercise);
                                WorkoutExerciseGroup? workoutExerciseGroup = await widget.workoutService.getWorkoutExerciseGroup(workoutExerciseGroupId);
                                setState(() {
                                  workoutGroupDtos.add(
                                    WorkoutGroupDto(
                                      workoutExerciseGroup: workoutExerciseGroup!,
                                      exerciseSets: [],
                                      exercise: exercise,
                                    ),
                                  );
                                });
                              });
                            },
                            icon: Icon(
                              Icons.add_rounded,
                              size: 30,
                              color: mt(context).icon.accentColor,
                            ),
                            height: 38,
                            width: 38,
                            backgroundColor: mt(context).backgroundColor,
                            borderColor: mt(context).borderColor,
                          ),

                          const SizedBox(width: 8,),

                          MFlatButton(
                            onPressed: () => _showWorkoutOptions(),
                            icon: Icon(
                              Icons.more_horiz,
                              size: 25,
                              color: mt(context).icon.primaryColor,
                            ),
                            height: 38,
                            width: 38,
                            backgroundColor: mt(context).backgroundColor,
                            borderColor: mt(context).borderColor,
                          ),

                          const SizedBox(width: 8,),

                          _timePercent != 0 ?
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadiusDirectional.circular(8),
                              child: Container(
                                height: 38,
                                child: Stack(
                                  children: [

                                    LinearProgressIndicator(
                                      backgroundColor: mt(context).foregroundColor,
                                      color: mt(context).accentColor,
                                      value: _timePercent,
                                      minHeight: 38,
                                    ),
                                    Center(
                                      child: Text(
                                        _timeFormatted,
                                        style: TextStyle(
                                          color: _timePercent > 0.5 ? mt(context).text.whiteColor : mt(context).text.primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    MFlatButton(
                                      onPressed: () {
                                        showTimerPickerDialog(context: context).then(
                                              (value) {
                                            if(value == null) return;
                                            _startTimer(value);
                                          },
                                        );
                                      },
                                      expand: false,
                                      backgroundColor: Colors.transparent,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                              :
                          MFlatButton(
                            onPressed: (){
                              showTimerPickerDialog(context: context).then(
                                    (value) {
                                  if(value == null) return;
                                  _startTimer(value);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.timer,
                              size: 21,
                              color: mt(context).text.primaryColor,
                            ),
                            height: 38,
                            width: 38,
                            backgroundColor: mt(context).backgroundColor,
                            borderColor: mt(context).borderColor,
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(width: 8,),

                    MFlatButton(
                      onPressed: (){
                        /*setState(() {
                              timerActive = !timerActive;
                            });*/
                      },
                      text: Text(
                        'Finish',
                        style: TextStyle(
                          color: mt(context).text.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      height: 38,
                      width: 84,
                      backgroundColor: mt(context).flatButton.completeColor,
                    ),
                  ],
                ),
              ),

              /*LinearProgressIndicator(
                    value: state.activeExerciseSets.where((activeExerciseSet) => activeExerciseSet.checked == 1).length / state.activeExerciseSets.length,
                  ),*/
              /*TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(seconds: 25),
                    builder: (context, value, _) => LinearProgressIndicator(value: value),
                  ),*/

              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workout.name,
                                style: TextStyle(
                                    color: mt(context).text.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25
                                ),
                              ),
                              const SizedBox(height: 4,),
                              StreamBuilder(
                                stream: Stream.periodic(const Duration(seconds: 1)),
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  return Text(
                                    workoutDuration(workout.timestamp),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: mt(context).text.secondaryColor
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        )
                      ])
                    ),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: workoutGroupDtos.length,
                        (context, index) => ExerciseGroupWidget(
                          exercise: workoutGroupDtos[index].exercise,
                          exerciseSets: workoutGroupDtos[index].exerciseSets,
                          onExerciseSetAdd: () async {
                            int temporaryId = DateTime.now().millisecondsSinceEpoch;
                            setState(() {
                              workoutGroupDtos[index].exerciseSets.add(
                                ExerciseSet(
                                  exerciseSetId: temporaryId,
                                  option1: 0,
                                ),
                              );
                            });
                            int workoutExerciseSetId = await widget.workoutService.addWorkoutExerciseSet(
                              workoutId: workout.workoutId!,
                              workoutExerciseGroupId: workoutGroupDtos[index].workoutExerciseGroup.workoutExerciseGroupId!,
                            );
                            int workoutExerciseSetIndex =workoutGroupDtos[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == temporaryId);
                            workoutGroupDtos[index].exerciseSets[workoutExerciseSetIndex] = workoutGroupDtos[index].exerciseSets[workoutExerciseSetIndex].copyWith(exerciseSetId: workoutExerciseSetId);
                          },
                          onExerciseSetUpdate: (value) {
                            int exerciseSetIndex = workoutGroupDtos[index].exerciseSets.indexWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                            workoutGroupDtos[index].exerciseSets[exerciseSetIndex] = value;
                            widget.workoutService.updateWorkoutExerciseSet(
                              exerciseSet: value,
                              workoutId: workout.workoutId!,
                              workoutExerciseGroupId: workoutGroupDtos[index].workoutExerciseGroup.workoutExerciseGroupId!
                            );
                          },
                          onExerciseSetDelete: (value) {
                            setState(() {
                              workoutGroupDtos[index].exerciseSets.removeWhere((exerciseSet) => exerciseSet.exerciseSetId == value.exerciseSetId);
                            });
                            widget.workoutService.deleteWorkoutExerciseSet(
                              workoutExerciseSetId: value.exerciseSetId
                            );
                          },
                          checkboxEnabled: true,
                        ),
                      ),
                    ),

                    SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 30, 15, 60),
                            child: MFlatButton(
                              onPressed: () {},
                              expand: false,
                              backgroundColor: mt(context).flatButton.errorColor,
                              text: Text(
                                'Discard Workout',
                                style: TextStyle(
                                    color: mt(context).text.errorColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900
                                ),
                              ),
                            ),
                          ),
                        ])
                    )

                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _startTimer (Timed timed) {
    int totalTime = timed.second + (timed.minute * 60) + (timed.hour * 60 * 60);
    int modifiedTime = timed.second + (timed.minute * 60) + (timed.hour * 60 * 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      modifiedTime = modifiedTime - 1;
      setState(() {
        if (modifiedTime >= 0) {
          _timePercent = modifiedTime / totalTime;
          _timeFormatted = secondsToTime(modifiedTime );
        } else {
          _timer.cancel();
        }
      });
    });
  }



  void _pauseWorkout(BuildContext context) {
    widget.isWorkoutActive(false);
    context.read<WorkoutBloc>().add(WorkoutPause());
    Navigator.pop(context);
  }

  ///
  ///
  ///

  void _showWorkoutOptions() {
    showBottomSheetDialog(
      context: context,
      onClose: () {},
      height: 270,
      child: Material(
        color: mt(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ListTile(
              onTap: () {},
              horizontalTitleGap: 15,
              leading: Container(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.drive_file_rename_outline_rounded,
                  color: mt(context).icon.accentColor,
                  size: 26,
                ),
              ),
              title: Text(
                'Rename Workout',
                style: TextStyle(
                  color: mt(context).text.primaryColor,
                  fontSize: 17
                ),
              ),
            ),

            ListTile(
              onTap: () {},
              horizontalTitleGap: 15,
              leading: Container(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(
                  CupertinoIcons.arrow_up_arrow_down,
                  color: mt(context).icon.accentColor,
                  size: 24,
                ),
              ),
              title: Text(
                'Reorder Exercises',
                style: TextStyle(
                  color: mt(context).text.primaryColor,
                  fontSize: 17
                ),
              ),
            ),

            ListTile(
              onTap: () => _pauseWorkout(context),
              horizontalTitleGap: 15,
              leading: Container(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.pause_circle_outline_rounded,
                  color: mt(context).icon.accentColor,
                  size: 26,
                ),
              ),
              title: Text(
                'Pause Workout',
                style: TextStyle(
                  color: mt(context).text.primaryColor,
                  fontSize: 17
                ),
              ),
            ),

            ListTile(
              onTap: () {},
              horizontalTitleGap: 15,
              leading: Container(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.delete_rounded,
                  color: mt(context).icon.errorColor,
                  size: 26,
                ),
              ),
              title: Text(
                'Discard Workout',
                style: TextStyle(
                  color: mt(context).text.errorColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            const SizedBox(height:9),
          ],
        ),
      )
    );
  }

}
