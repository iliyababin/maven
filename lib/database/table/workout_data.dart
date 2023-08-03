import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/common.dart';
import '../database.dart';

@Entity(
  tableName: 'workout_data',
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
class WorkoutData extends Equatable {
  const WorkoutData({
    this.id,
    required this.isActive,
    required this.timeElapsed,
    required this.routineId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'is_active')
  final bool isActive;

  @ColumnInfo(name: 'time_elapsed')
  final Timed timeElapsed;

  @ColumnInfo(name: 'routine_id')
  final int routineId;

  WorkoutData copyWith({
    int? id,
    bool? isActive,
    Timed? timeElapsed,
    int? routineId,
  }) {
    return WorkoutData(
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      routineId: routineId ?? this.routineId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        isActive,
        timeElapsed,
        routineId,
      ];
}
