import 'package:flutter/material.dart';

import '../../feature/theme/theme.dart';


class ExerciseSetType {
  final String name;

  const ExerciseSetType._(this.name);

  static const regular = ExerciseSetType._('Regular');
  static const warmup = ExerciseSetType._('Warmup');
  static const failure = ExerciseSetType._('Failure');
  static const drop = ExerciseSetType._('Drop');
  static const cooldown = ExerciseSetType._('Cool-down');

  String get abbreviated => name.substring(0, 1).toUpperCase();

  Color color(BuildContext context) {
    switch (this) {
      case ExerciseSetType.regular:
        return T(context).color.primary;
      case ExerciseSetType.warmup:
        return T(context).color.warmup;
      case ExerciseSetType.failure:
        return T(context).color.error;
      case ExerciseSetType.drop:
        return T(context).color.drop;
      case ExerciseSetType.cooldown:
        return T(context).color.cooldown;
    }
    return Colors.transparent;
  }

  static ExerciseSetType fromName(String setTypeString) {
    switch (setTypeString) {
      case 'Regular':
        return ExerciseSetType.regular;
      case 'Warmup':
        return ExerciseSetType.warmup;
      case 'Failure':
        return ExerciseSetType.failure;
      case 'Drop':
        return ExerciseSetType.drop;
      case 'Cool-down':
        return ExerciseSetType.cooldown;
    }
    return ExerciseSetType.regular;
  }

  static const values = [
    regular,
    warmup,
    failure,
    drop,
    cooldown,
  ];
}