import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'bar',
  primaryKeys: [
    'id',
  ],
)
class Bar extends Equatable {
  const Bar({
    this.id,
    required this.name,
    required this.weight,
  });

  const Bar.empty()
      : this(
          name: '',
          weight: 0,
        );

  @ColumnInfo(name: 'id')
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'weight')
  final double weight;

  Bar copyWith({
    int? id,
    String? name,
    double? weight,
  }) {
    return Bar(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        weight,
      ];

  @override
  String toString() {
    return 'Bar { id: $id, name: $name, weight: $weight }';
  }
}
