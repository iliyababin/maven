
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../enum/exercise_set_type.dart';
import 'session.dart';
import 'session_exercise_group.dart';

@Entity(
  tableName: 'session_exercise_set',
  primaryKeys: [
    'session_exercise_set_id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['session_exercise_group_id'],
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
class SessionExerciseSet extends Equatable {
  const SessionExerciseSet({
    this.completeExerciseSetId,
    required this.option1,
    this.option2,
    required this.setType,
    required this.sessionExerciseGroupId,
    required this.sessionId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'session_exercise_set_id')
  final int? completeExerciseSetId;

  @ColumnInfo(name: 'option_1')
  final int option1;

  @ColumnInfo(name: 'option_2')
  final int? option2;

  @ColumnInfo(name: 'set_type')
  final ExerciseSetType setType;

  @ColumnInfo(name: 'session_exercise_group_id')
  final int sessionExerciseGroupId;

  @ColumnInfo(name: 'session_id')
  final int sessionId;

  @override
  List<Object?> get props => [
    completeExerciseSetId,
    option1,
    option2,
    setType,
    sessionExerciseGroupId,
    sessionId,
  ];
}