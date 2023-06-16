
import 'package:floor/floor.dart';
import 'package:maven/database/enum/weight_unit.dart';

import '../../common/model/timed.dart';
import 'bar.dart';
import 'exercise.dart';
import 'exercise_group.dart';
import 'session.dart';

@Entity(
  tableName: 'session_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['session_id'],
      parentColumns: ['id'],
      entity: Session,
    ),
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
    ),
  ],
)
class SessionExerciseGroup extends ExerciseGroup {
  const SessionExerciseGroup({
    super.id,
    required super.barId,
    required super.timer,
    required super.exerciseId,
    required super.weightUnit,
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
    int? order,
    int? sessionId,
  }) {
    return SessionExerciseGroup(
      id: id ?? this.id,
      barId: barId ?? this.barId,
      timer: timer ?? this.timer,
      exerciseId: exerciseId ?? this.exerciseId,
      weightUnit: weightUnit ?? this.weightUnit,
      order: order ?? this.order,
      sessionId: sessionId ?? this.sessionId,
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    barId,
    timer,
    exerciseId,
    weightUnit,
    order,
    sessionId,
  ];
}