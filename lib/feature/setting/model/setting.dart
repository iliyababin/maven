import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';

class Setting extends Equatable {
  const Setting({
    required this.theme,
    required this.themes,
    required this.weightUnit,
    required this.distanceUnit,
    required this.locale,
  });

  final AppTheme theme;
  final List<AppTheme> themes;
  final WeightUnit weightUnit;
  final DistanceUnit distanceUnit;
  final Locale locale;

  double parseWeight(double volume) {
    if (weightUnit == WeightUnit.lbs) {
      return volume;
    } else {
      return volume * 0.45359237;
    }
  }

  double parseHeight(double height) {
    switch (distanceUnit) {
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
    }
  }


  Setting copyWith ({
    AppTheme? theme,
    List<AppTheme>? themes,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    Locale? locale,
  }) {
    return Setting(
      theme: theme ?? this.theme,
      themes: themes ?? this.themes,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        themes,
        weightUnit,
        distanceUnit,
        locale,
      ];

}
