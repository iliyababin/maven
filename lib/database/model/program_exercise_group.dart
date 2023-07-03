import 'package:floor/floor.dart';

import '../../common/model/model.dart';
import '../database.dart';

@Entity(
  tableName: 'program_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
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
    ForeignKey(
      childColumns: ['program_template_id'],
      parentColumns: ['id'],
      entity: ProgramTemplate,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class ProgramExerciseGroup extends BaseExerciseGroup {
  const ProgramExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.distanceUnit,
    required super.exerciseId,
    required super.barId,
    required this.programTemplateId,
    super.routineId = -1,
  }) ;

  @ColumnInfo(name: 'program_template_id')
  final int programTemplateId;

  @override
  ProgramExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? exerciseId,
    int? barId,
    int? programTemplateId,
    int? routineId,
  }) {
    return ProgramExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      programTemplateId: programTemplateId ?? this.programTemplateId,
      routineId: routineId ?? this.routineId,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    programTemplateId,
  ];
}