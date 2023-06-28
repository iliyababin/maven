import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/extension.dart';
import 'package:video_player/video_player.dart';

import '../../../common/dialog/show_bottom_sheet_dialog.dart';
import '../../../common/dialog/timer_picker_dialog.dart';
import '../../../database/database.dart';
import '../../../theme/theme.dart';
import '../bloc/exercise_bloc.dart';

class ExerciseDetailView extends StatefulWidget {
  const ExerciseDetailView({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  State<ExerciseDetailView> createState() => _ExerciseDetailViewState();
}

class _ExerciseDetailViewState extends State<ExerciseDetailView> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.exercise.videoPath)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {
          _controller.setLooping(true);
          _controller.play();
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(
            T(context).space.large,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: T(context).color.outline,
                  style: BorderStyle.solid,
              ),
              borderRadius: BorderRadiusDirectional.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(12),
              child: _controller.value.isInitialized ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ) : Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monitor_heart,
              ),
            ],
          ),
          title: Text(
            'Muscle',
            style: T(context).textStyle.bodyLarge,
          ),
          subtitle: Text(
            widget.exercise.muscle.name.parseMuscleToString(),
            style: T(context).textStyle.bodyMedium,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.health_and_safety,
              ),
            ],
          ),
          title: Text(
            'Muscle Group',
            style: T(context).textStyle.bodyLarge,
          ),
          subtitle: Text(
            widget.exercise.muscleGroup.name.capitalize(),
            style: T(context).textStyle.bodyMedium,
          ),
        ),
        ListTile(
          onTap: () {
            showBottomSheetDialog(
                context: context,
                child: TimedPickerDialog(
                  initialValue: widget.exercise.timer,
                  onSubmit: (value) {
                    context.read<ExerciseBloc>().add(ExerciseUpdate(exercise: widget.exercise.copyWith(timer: value)));
                  },
                ),
                onClose: (){}
            );
          },
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer,),
            ],
          ),
          title: Text(
            'Timer',
            style: T(context).textStyle.bodyLarge,
          ),
          subtitle: Text(
            widget.exercise.timer.toString(),
            style: T(context).textStyle.bodyMedium,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category,
              ),
            ],
          ),
          title: Text(
            'Equipment',
            style: T(context).textStyle.bodyLarge,
          ),
          subtitle: Text(
            widget.exercise.equipment.name.capitalize(),
            style: T(context).textStyle.bodyMedium,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tune,
              ),
            ],
          ),
          title: Text(
            'Type',
            style: T(context).textStyle.bodyLarge,
          ),
          subtitle: Text(
            // Name of exercise fields
            widget.exercise.fields.map((obj) => obj.type.name.capitalize()).join(' | '),
            style: T(context).textStyle.bodyMedium,
          ),
        ),
        widget.exercise.weightUnit != null ? ListTile(
          onTap: (){},
          leading: const Icon(
            Icons.scale,
          ),
          title: Text(
            'Weight Unit',
            style: T(context).textStyle.bodyLarge,
          ),
          subtitle: Text(
            widget.exercise.weightUnit!.name.toString().capitalize(),
            style: T(context).textStyle.bodyMedium,
          ),
        ) : Container(),
        widget.exercise.distanceUnit != null ? ListTile(
          onTap: (){},
          leading: const Icon(
            Icons.directions_run,
          ),
          title: Text(
            'Distance Unit',
            style: T(context).textStyle.bodyLarge,
          ),
          subtitle: Text(
            widget.exercise.distanceUnit!.name.toString().capitalize(),
            style: T(context).textStyle.bodyMedium,
          ),
        ) : Container(),
      ],
    );
  }
}