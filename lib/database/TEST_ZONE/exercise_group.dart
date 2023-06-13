/*
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/timed.dart';
import '../model/bar.dart';
import '../model/exercise.dart';



@Entity(
  tableName: 'session',
  primaryKeys: [
    'id',
  ],
)
class Session extends Routine {
  const Session({
    super.id,
    required super.name,
    required super.description,
    required super.timestamp,
    required this.duration,
  });

  final Duration duration;

  @override
  Routine copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? timestamp,
    Duration? duration,
  }) {
    return Session(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        timestamp,
      ];
}



abstract class ExerciseGroup {
  const ExerciseGroup({
    this.id,
    required this.timer,
    required this.weightUnit,
    required this.exerciseId,
    this.barId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'timer')
  final Timed timer;

  @ColumnInfo(name: 'weight_unit')
  final WeightUnit weightUnit;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'bar_id')
  final int? barId;
}

@Entity(
  tableName: 'template_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['id'],
      parentColumns: ['id'],
      entity: Template,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TemplateExerciseGroup extends ExerciseGroup {
  TemplateExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.exerciseId,
    super.barId,
    required this.templateId,
  });

  @ColumnInfo(name: 'id')
  final int templateId;
}






@Entity(
  tableName: 'workout_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['id'],
      entity: Exercise,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['id'],
      parentColumns: ['id'],
      entity: Workout,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class WorkoutExerciseGroup extends ExerciseGroup {
  WorkoutExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.exerciseId,
    super.barId,
    required this.workoutId,
  });

  @ColumnInfo(name: 'id')
  final int workoutId;
}



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
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['session_id'],
      parentColumns: ['id'],
      entity: Session,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class SessionExerciseGroup extends ExerciseGroup {
  SessionExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.exerciseId,
    super.barId,
    required this.sessionId,
  });

  @ColumnInfo(name: 'session_id')
  final int sessionId;
}



enum WeightUnit {
  kg,
  lb,
}
*/
