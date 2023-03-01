import 'dart:async';

import 'package:Maven/common/util/general_utils.dart';
import 'package:flutter/material.dart';

import '../../../common/dialog/show_timer_picker_dialog.dart';
import '../../../common/model/timed.dart';
import '../../../theme/m_themes.dart';
import '../../../widget/m_flat_button.dart';

class ExerciseTimerWidget extends StatefulWidget {
  const ExerciseTimerWidget({Key? key,
    required this.controller,
  }) : super(key: key);

  final ExerciseTimerController controller;

  @override
  State<ExerciseTimerWidget> createState() => _ExerciseTimerWidgetState();
}

class _ExerciseTimerWidgetState extends State<ExerciseTimerWidget> {

  int timeLeft = 0;
  int totalTime = 0;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        timeLeft = widget.controller.timeLeft.toInt();
        totalTime = widget.controller.totalTime.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return timeLeft != 0 ?
    Expanded(
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.circular(8),
        child: SizedBox(
          height: 38,
          child: Stack(
            children: [
              LinearProgressIndicator(
                backgroundColor: mt(context).foregroundColor,
                color: mt(context).accentColor,
                value: timeLeft / totalTime,
                minHeight: 38,
              ),
              Center(
                child: Text(
                  secondsToTime(timeLeft),
                  style: TextStyle(
                    color: timeLeft / totalTime > 0.5 ? mt(context).text.whiteColor : mt(context).text.primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              MFlatButton(
                onPressed: () async {
                },
                expand: false,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    )
        :
    MFlatButton(
      onPressed: () async {
        showTimerPickerDialog(context: context).then((value) {
          if (value == null) return;
          widget.controller.startTimer(value);
        });
      },
      leading: Icon(
        Icons.timer,
        size: 21,
        color: mt(context).text.primaryColor,
      ),
      height: 38,
      width: 38,
      backgroundColor: mt(context).backgroundColor,
      borderColor: mt(context).borderColor,
    );
  }
}

class ExerciseTimerController extends ChangeNotifier {
  ExerciseTimerController();

  Timer? timer;
  int timeLeft = 0;
  int totalTime = 0;

  void startTimer(Timed timed) {
    timeLeft = timed.toSeconds();
    totalTime = timed.toSeconds();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeLeft == 0) {
        timer!.cancel();
        notifyListeners();
      } else {
        timeLeft--;
        notifyListeners();
      }
    });
  }
}

