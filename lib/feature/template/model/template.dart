
import 'package:maven/database/database.dart';

import '../../../common/common.dart';
import '../../exercise/model/exercise_group.dart';

class Template extends Routine {
  const Template({
    super.id,
    required super.name,
    required super.note,
    required super.timestamp,
    required super.type,
    this.data,
    this.exerciseGroups = const [],
    this.musclePercentages = const {},
    this.duration = const Timed.zero(),
    this.volume = 0,
  });

  final TemplateData? data;
  final List<ExerciseGroup> exerciseGroups;
  final Map<Muscle, double> musclePercentages;
  final Timed duration;
  final double volume;
}