
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'setting',
  primaryKeys: [
    'id',
  ],
)
class Setting extends Equatable {
  const Setting({
    required this.id,
    required this.languageCode,
    required this.countryCode,
  });

  @PrimaryKey()
  final int id;

  @ColumnInfo(name: 'language_code')
  final String languageCode;

  @ColumnInfo(name: 'country_code')
  final String countryCode;

  Setting copyWith({
    int? id,
    String? languageCode,
    String? countryCode,
  }) {
    return Setting(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [
    id,
    languageCode,
    countryCode,
  ];
}