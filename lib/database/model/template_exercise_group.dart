import 'package:floor/floor.dart';
import 'package:maven/database/model/exercise_group.dart';

import '../../common/model/timed.dart';
import 'bar.dart';
import 'exercise.dart';
import 'template.dart';
import 'weight_unit.dart';

@Entity(
  tableName: 'template_exercise_group',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['bar_id'],
      entity: Bar,
    ),
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['exercise_id'],
      entity: Exercise,
    ),
    ForeignKey(
      childColumns: ['template_id'],
      parentColumns: ['id'],
      entity: Template,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TemplateExerciseGroup extends ExerciseGroup {
  const TemplateExerciseGroup({
    super.id,
    required super.timer,
    required super.weightUnit,
    required super.barId,
    required super.exerciseId,
    required this.templateId,
  });

  @ColumnInfo(name: 'template_id')
  final int templateId;

  @override
  TemplateExerciseGroup copyWith({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    int? barId,
    int? exerciseId,
    int? templateId,
  }) {
    return TemplateExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      templateId: templateId ?? this.templateId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    timer,
    weightUnit,
    barId,
    exerciseId,
    templateId,
  ];
}