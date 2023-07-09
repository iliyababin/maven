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
    required this.weightUnit,
    required this.distanceUnit,
  });

  @PrimaryKey()
  final int id;

  @ColumnInfo(name: 'language_code')
  final String languageCode;

  @ColumnInfo(name: 'country_code')
  final String countryCode;

  @ColumnInfo(name: 'theme_id')
  final int themeId;

  @ColumnInfo(name: 'weight_unit')
  final WeightUnit weightUnit;

  @ColumnInfo(name: 'distance_unit')
  final DistanceUnit distanceUnit;

  BaseSetting copyWith({
    int? id,
    String? languageCode,
    String? countryCode,
    int? themeId,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
  }) {
    return BaseSetting(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      countryCode: countryCode ?? this.countryCode,
      themeId: themeId ?? this.themeId,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
    );
  }

  @override
  List<Object?> get props => [
        id,
        languageCode,
        countryCode,
        themeId,
        weightUnit,
        distanceUnit,
      ];
}
