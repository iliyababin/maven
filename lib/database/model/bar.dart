import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'bar',
  primaryKeys: [
    'bar_id',
  ],
)
class Bar extends Equatable {
  const Bar({
    this.barId,
    required this.name,
    required this.weight,
  });

  @ColumnInfo(name: 'bar_id')
  @PrimaryKey(autoGenerate: true)
  final int? barId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'weight')
  final double weight;


  Bar copyWith({
    int? barId,
    String? name,
    double? weight,
  }) {
    return Bar(
      barId: barId ?? this.barId,
      name: name ?? this.name,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object?> get props => [
    barId,
    name,
    weight,
  ];
}

List<Bar> getDefaultBars() => [
  const Bar(
    barId: 1,
    name: 'Olympic',
    weight: 45,
  ),
  const Bar(
    barId: 2,
    name: 'EZ Curl',
    weight: 15,
  ),
  const Bar(
    barId: 3,
    name: 'Trap Bar',
    weight: 55,
  ),
];