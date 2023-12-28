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
    required this.type,
  });

  Routine.empty()
      : id = 1,
        name = '',
        note = '',
        timestamp = DateTime.now(),
        type = RoutineType.template;

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String note;

  @ColumnInfo(name: 'timestamp')
  final DateTime timestamp;

  @ColumnInfo(name: 'type')
  final RoutineType type;

  Routine copyWith({
    int? id,
    String? name,
    String? note,
    DateTime? timestamp,
    RoutineType? type,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        note,
        timestamp,
        type,
      ];
}
