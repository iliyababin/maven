import 'package:floor/floor.dart';

import 'template.dart';
import 'template_exercise_group.dart';

@Entity(
  tableName: 'template_exercise_set',
  foreignKeys: [
    ForeignKey(
      childColumns: ['template_exercise_group_id'],
      parentColumns: ['template_exercise_group_id'],
      entity: TemplateExerciseGroup,
    ),
    ForeignKey(
      childColumns: ['template_id'],
      parentColumns: ['template_id'],
      entity: Template,
    ),
  ]
)
class TemplateExerciseSet {
  
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'template_exercise_set_id')
  final int? templateExerciseSetId;

  @ColumnInfo(name: 'option_1')
  final int option1;

  @ColumnInfo(name: 'option_2')
  final int? option2;

  @ColumnInfo(name: 'template_exercise_group_id')
  final int exerciseGroupId;

  @ColumnInfo(name: 'template_id')
  final int templateId;

  TemplateExerciseSet({
    this.templateExerciseSetId,
    required this.option1,
    this.option2,
    required this.exerciseGroupId,
    required this.templateId,
  });
}
