import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:maven/common/extension/extension.dart';

import '../database.dart';

@Entity(
  tableName: 'settings',
  primaryKeys: [
    'id',
  ],
)
class Settings extends Equatable {
  const Settings({
    required this.id,
    required this.locale,
    required this.themeId,
    required this.unit,
    required this.sessionWeeklyGoal,
    required this.useSystemDefaultTheme,
    required this.useDynamicColor,
  });

  const Settings.empty()
      : this(
          id: 1,
          locale: const Locale('en', 'US'),
          themeId: 1,
          unit: Unit.imperial,
          sessionWeeklyGoal: 3,
          useSystemDefaultTheme: true,
          useDynamicColor: true,
        );

  @PrimaryKey()
  final int id;

  @ColumnInfo(name: 'locale')
  final Locale locale;

  @ColumnInfo(name: 'theme_id')
  final int themeId;

  @ColumnInfo(name: 'unit')
  final Unit unit;

  @ColumnInfo(name: 'session_weekly_goal')
  final int sessionWeeklyGoal;

  @ColumnInfo(name: 'use_system_default_theme')
  final bool useSystemDefaultTheme;

  @ColumnInfo(name: 'use_dynamic_color')
  final bool useDynamicColor;

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

  Settings copyWith({
    int? id,
    Locale? locale,
    int? themeId,
    Unit? unit,
    int? sessionWeeklyGoal,
    bool? useSystemDefaultTheme,
    bool? useDynamicColor,
  }) {
    return Settings(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      themeId: themeId ?? this.themeId,
      unit: unit ?? this.unit,
      sessionWeeklyGoal: sessionWeeklyGoal ?? this.sessionWeeklyGoal,
      useSystemDefaultTheme: useSystemDefaultTheme ?? this.useSystemDefaultTheme,
      useDynamicColor: useDynamicColor ?? this.useDynamicColor,
    );
  }

  @override
  List<Object?> get props =>
      [
        id,
        locale,
        themeId,
        unit,
        sessionWeeklyGoal,
        useSystemDefaultTheme,
        useDynamicColor,
      ];
}
