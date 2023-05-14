import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'complete',
  primaryKeys: [
    'complete_id',
  ],
)
class Complete extends Equatable{
  const Complete({
    this.completeId,
    required this.name,
    required this.duration,
    required this.timestamp,
  });

  @ColumnInfo(name: 'complete_id')
  final int? completeId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'duration')
  final Duration duration;

  @ColumnInfo(name: 'timestamp')
  final DateTime timestamp;

  @override
  List<Object?> get props => [
    completeId,
    name,
    duration,
    timestamp,
  ];
}