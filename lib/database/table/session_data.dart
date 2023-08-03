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
    ForeignKey(
      childColumns: ['import_id'],
      parentColumns: ['id'],
      entity: Import,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class SessionData extends Equatable {
  const SessionData({
    this.id,
    required this.timeElapsed,
    required this.routineId,
    this.importId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'time_elapsed')
  final Timed timeElapsed;

  @ColumnInfo(name: 'routine_id')
  final int routineId;

  @ColumnInfo(name: 'import_id')
  final int? importId;

  @override
  List<Object?> get props => [
    id,
    timeElapsed,
    routineId,
    importId,
  ];
}