import 'package:floor/floor.dart';
import 'package:maven/database/database.dart';

import '../../common/model/timed.dart';

@Entity(
  tableName: 'template_exercise_group',
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
    required super.distanceUnit,
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
    DistanceUnit? distanceUnit,
    int? barId,
    int? exerciseId,
    int? templateId,
  }) {
    return TemplateExerciseGroup(
      id: id ?? this.id,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      barId: barId ?? this.barId,
      exerciseId: exerciseId ?? this.exerciseId,
      templateId: templateId ?? this.templateId,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        templateId,
      ];
}
