import 'package:floor/floor.dart';

import 'routine.dart';

@Entity(
  tableName: 'workout',
  primaryKeys: [
    'id',
  ],
)
class Workout extends Routine {
  const Workout({
    super.id,
    required super.name,
    required super.description,
    required super.timestamp,
    required this.active,
  });

  final bool active;

  @override
  Workout copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? timestamp,
    bool? active,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      active: active ?? this.active,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    timestamp,
    active,
  ];
}