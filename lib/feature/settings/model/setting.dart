import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';

class Setting extends Equatable {
  const Setting({
    required this.theme,
    required this.themes,
    required this.unit,
    required this.locale,
    required this.sessionWeeklyGoal,
  });

  final AppTheme theme;
  final List<AppTheme> themes;
  final Unit unit;
  final Locale locale;
  final int sessionWeeklyGoal;

  String parseWeight(double volume) {
    if (unit == Unit.imperial) {
      return '${volume.toStringAsFixed(2).truncateZeros} lbs';
    } else {
      return '${(volume * 0.45359237).toStringAsFixed(2).truncateZeros} kgs';
    }
  }

  double parseHeight(double height) {
    return height;
    /*switch (unit) {
      case DistanceUnit.kilometer:
        return height / 1000;
      case DistanceUnit.mile:
        return height / 1609.344;
      case DistanceUnit.feet:
        return height / 3.28084;
      case DistanceUnit.meter:
        return height;
      case DistanceUnit.centimeter:
        return height / 100;
      case DistanceUnit.inch:
        return height / 39.37008;
      default:
        return height;
    }*/
  }

  Setting copyWith({
    AppTheme? theme,
    List<AppTheme>? themes,
    Unit? unit,
    DistanceUnit? distanceUnit,
    Locale? locale,
    int? sessionWeeklyGoal,
  }) {
    return Setting(
      theme: theme ?? this.theme,
      themes: themes ?? this.themes,
      unit: unit ?? this.unit,
      locale: locale ?? this.locale,
      sessionWeeklyGoal: sessionWeeklyGoal ?? this.sessionWeeklyGoal,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        themes,
        unit,
        locale,
        sessionWeeklyGoal,
      ];
}
