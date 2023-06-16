import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'session',
  primaryKeys: [
    'id',
  ],
)
class Session extends Routine {
  const Session({
    super.id,
    required super.name,
    required super.description,
    required super.timestamp,
    required this.duration,
  });

  @ColumnInfo(name: 'duration')
  final Duration duration;

  @override
  Session copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? timestamp,
    Duration? duration,
  }) {
    return Session(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        timestamp,
        duration,
      ];
}
