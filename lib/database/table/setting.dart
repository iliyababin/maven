import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'setting',
  primaryKeys: [
    'id',
  ],
)
class BaseSetting extends Equatable {
  const BaseSetting({
    required this.id,
    required this.languageCode,
    required this.countryCode,
    required this.themeId,
    required this.unit,
    required this.sessionWeeklyGoal,
    required this.useSystemDefaultTheme,
    required this.useDynamicColor,
  });

  const BaseSetting.base() : this(
    id: 1,
    languageCode: 'en',
    countryCode: 'US',
    themeId: 1,
    unit: Unit.imperial,
    sessionWeeklyGoal: 3,
    useSystemDefaultTheme: true,
    useDynamicColor: true,
  );

  @PrimaryKey()
  final int id;

  @ColumnInfo(name: 'language_code')
  final String languageCode;

  @ColumnInfo(name: 'country_code')
  final String countryCode;

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

  BaseSetting copyWith({
    int? id,
    String? languageCode,
    String? countryCode,
    int? themeId,
    Unit? unit,
    int? sessionWeeklyGoal,
    bool? useSystemDefaultTheme,
    bool? useDynamicColor,
  }) {
    return BaseSetting(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      countryCode: countryCode ?? this.countryCode,
      themeId: themeId ?? this.themeId,
      unit: unit ?? this.unit,
      sessionWeeklyGoal: sessionWeeklyGoal ?? this.sessionWeeklyGoal,
      useSystemDefaultTheme: useSystemDefaultTheme ?? this.useSystemDefaultTheme,
      useDynamicColor: useDynamicColor ?? this.useDynamicColor,
    );
  }

  @override
  List<Object?> get props => [
        id,
        languageCode,
        countryCode,
        themeId,
        unit,
        sessionWeeklyGoal,
        useSystemDefaultTheme,
        useDynamicColor,
      ];
}
