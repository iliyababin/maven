import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/common.dart';
import '../database.dart';

@Entity(
  tableName: 'session_data',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['routine_id'],
      parentColumns: ['id'],
      entity: Routine,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class SessionData extends Equatable {
  const SessionData({
    this.id,
    required this.timeElapsed,
    required this.routineId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'time_elapsed')
  final Timed timeElapsed;

  @ColumnInfo(name: 'routine_id')
  final int routineId;

  @override
  List<Object?> get props => [
    id,
    timeElapsed,
    routineId,
  ];
}