import 'package:floor/floor.dart';

import '../../common/model/model.dart';
import '../database.dart';

@Entity(
  tableName: 'session_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
    ),
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['session_id'],
      parentColumns: ['id'],
      entity: Session,
    ),
  ],
)
class SessionExerciseGroup extends ExerciseGroup {
  const SessionExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.distanceUnit,
    required super.exerciseId,
    required super.barId,
    required this.order,
    required this.sessionId,
  });

  @ColumnInfo(name: 'order')
  final int order;

  @ColumnInfo(name: 'session_id')
  final int sessionId;

  @override
  SessionExerciseGroup copyWith({
    int? id,
    int? barId,
    Timed? timer,
    int? exerciseId,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? order,
    int? sessionId,
  }) {
    return SessionExerciseGroup(
      id: id ?? this.id,
      barId: barId ?? this.barId,
      timer: timer ?? this.timer,
      exerciseId: exerciseId ?? this.exerciseId,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      order: order ?? this.order,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        order,
        sessionId,
      ];
}
