import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'session_exercise_set',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_group_id'],
      parentColumns: ['id'],
      entity: SessionExerciseGroup,
    ),
    ForeignKey(
      childColumns: ['session_id'],
      parentColumns: ['id'],
      entity: Session,
    ),
  ],
)
class SessionExerciseSet extends ExerciseSet {
  const SessionExerciseSet({
    super.id,
    required super.type,
    required super.checked,
    required super.exerciseGroupId,
    super.data,
    required this.sessionId,
  });

  @ColumnInfo(name: 'session_id')
  final int sessionId;

  @override
  List<Object?> get props => [
    ...super.props,
    sessionId,
  ];
}