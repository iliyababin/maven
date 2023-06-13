import 'package:floor/floor.dart';

import '../../feature/exercise/model/set_type.dart';
import 'template.dart';
import 'template_exercise_group.dart';

@Entity(
  tableName: 'template_exercise_set',
  foreignKeys: [
    ForeignKey(
      childColumns: ['template_exercise_group_id'],
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
class TemplateExerciseSet {
  TemplateExerciseSet({
    this.templateExerciseSetId,
    required this.option1,
    this.option2,
    required this.setType,
    required this.templateExerciseGroupId,
    required this.templateId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'template_exercise_set_id')
  final int? templateExerciseSetId;

  @ColumnInfo(name: 'option_1')
  final int option1;

  @ColumnInfo(name: 'option_2')
  final int? option2;

  @ColumnInfo(name: 'set_type')
  final SetType setType;

  @ColumnInfo(name: 'template_exercise_group_id')
  final int templateExerciseGroupId;

  @ColumnInfo(name: 'template_id')
  final int templateId;
}
