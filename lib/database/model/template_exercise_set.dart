import 'package:floor/floor.dart';
import 'package:maven/database/model/exercise_set.dart';

import '../../feature/exercise/model/set_type.dart';
import '../database.dart';

@Entity(
  tableName: 'template_exercise_set',
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_group_id'],
      parentColumns: ['id'],
      entity: TemplateExerciseGroup,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['template_id'],
      parentColumns: ['id'],
      entity: Template,
      onDelete: ForeignKeyAction.cascade,
    ),
  ]
)
class TemplateExerciseSet extends ExerciseSet {
  const TemplateExerciseSet({
    super.id,
    required super.type,
    required super.checked,
    required super.exerciseGroupId,
    super.data,
    required this.templateId,
  });

  @ColumnInfo(name: 'template_id')
  final int templateId;

  @override
  List<Object?> get props => [
    ...super.props,
    templateId,
  ];

  @override
  TemplateExerciseSet copyWith({
    int? id,
    SetType? type,
    bool? checked,
    int? exerciseGroupId,
    List<ExerciseSetData>? data,
    int? templateId,
  }) => TemplateExerciseSet(
    id: id ?? this.id,
    type: type ?? this.type,
    checked: checked ?? this.checked,
    exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
    data: data ?? this.data,
    templateId: templateId ?? this.templateId,
  );
}
