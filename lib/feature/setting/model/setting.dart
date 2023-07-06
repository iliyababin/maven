import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';

class Setting extends Equatable {
  const Setting({
    required this.theme,
    required this.themes,
    required this.weightUnit,
    required this.locale,
    required this.username,
    required this.description,
  });

  final AppTheme theme;
  final List<AppTheme> themes;
  final WeightUnit weightUnit;
  final Locale locale;
  final String username;
  final String description;

  double parseWeight(double volume) {
    if (weightUnit == WeightUnit.lbs) {
      return volume;
    } else {
      return volume * 0.45359237;
    }
  }

  Setting copyWith ({
    AppTheme? theme,
    List<AppTheme>? themes,
    WeightUnit? weightUnit,
    Locale? locale,
    String? username,
    String? description,
  }) {
    return Setting(
      theme: theme ?? this.theme,
      themes: themes ?? this.themes,
      weightUnit: weightUnit ?? this.weightUnit,
      locale: locale ?? this.locale,
      username: username ?? this.username,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        themes,
        weightUnit,
        locale,
        username,
        description,
      ];
}
