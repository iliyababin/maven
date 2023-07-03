import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

enum RoutineType {
  template,
  workout,
  session,
}

@Entity(
  tableName: 'routine',
  primaryKeys: [
    'id',
  ],
)
class Routine extends Equatable {
  const Routine({
    this.id,
    required this.name,
    required this.note,
    required this.timestamp,
    required this.sort,
    required this.type,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String note;

  @ColumnInfo(name: 'timestamp')
  final DateTime timestamp;

  @ColumnInfo(name: 'sort')
  final int sort;

  @ColumnInfo(name: 'type')
  final RoutineType type;

  Routine copyWith({
    int? id,
    String? name,
    String? note,
    DateTime? timestamp,
    int? sort,
    RoutineType? type,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      sort: sort ?? this.sort,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        note,
        timestamp,
        sort,
      ];
}
