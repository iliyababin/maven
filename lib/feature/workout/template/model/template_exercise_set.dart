import 'package:Maven/feature/workout/template/model/template.dart';
import 'package:Maven/feature/workout/template/model/template_exercise_group.dart';
import 'package:floor/floor.dart';

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
  int? templateExerciseSetId;

  @ColumnInfo(name: 'weight')
  int? weight;

  @ColumnInfo(name: 'reps')
  int? reps;

  @ColumnInfo(name: 'template_exercise_group_id')
  int exerciseGroupId;

  @ColumnInfo(name: 'template_id')
  int templateId;

  TemplateExerciseSet({
    this.templateExerciseSetId,
    this.weight,
    this.reps,
    required this.exerciseGroupId,
    required this.templateId,
  });

}
