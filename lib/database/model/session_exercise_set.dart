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
  SessionExerciseSet copyWith({
    int? id,
    ExerciseSetType? type,
    bool? checked,
    int? exerciseGroupId,
    List<ExerciseSetData>? data,
    int? sessionId,
  }) {
    return SessionExerciseSet(
      id: id ?? this.id,
      type: type ?? this.type,
      checked: checked ?? this.checked,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
      data: data ?? this.data,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    sessionId,
  ];
}