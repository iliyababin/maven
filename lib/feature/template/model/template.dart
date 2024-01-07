import 'package:equatable/equatable.dart';
import 'package:maven/database/database.dart';

import '../../../common/common.dart';
import '../../exercise/model/exercise_list.dart';

class Template extends Equatable {
  const Template({
    required this.routine,
    required this.data,
    required this.exerciseList,
    required this.musclePercentages,
    required this.duration,
    required this.volume,
  });

  final Routine routine;
  final TemplateData data;
  final ExerciseList exerciseList;
  final Map<Muscle, double> musclePercentages;
  final Timed duration;
  final double volume;

  @override
  List<Object?> get props => [
        routine,
        data,
        exerciseList,
        musclePercentages,
        duration,
        volume,
      ];
}