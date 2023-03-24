import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../../common/model/timed.dart';
import '../../equipment/model/bar.dart';
import '../../exercise/model/exercise.dart';
import 'template.dart';

@Entity(
  tableName: 'template_exercise_group',
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
      parentColumns: ['template_id'],
      entity: Template,
    ),
  ],
  primaryKeys: [
    'template_exercise_group_id',
  ],
)
class TemplateExerciseGroup extends Equatable {
  
  @ColumnInfo(name: 'template_exercise_group_id')
  @PrimaryKey(autoGenerate: true)
  final int? templateExerciseGroupId;

  @ColumnInfo(name: 'rest_timed')
  final Timed restTimed;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'template_id')
  final int templateId;

  const TemplateExerciseGroup({
    this.templateExerciseGroupId,
    required this.restTimed,
    required this.barId,
    required this.exerciseId,
    required this.templateId,
  });

  factory TemplateExerciseGroup.fromMap(Map<String, dynamic> json) {
    return TemplateExerciseGroup(
      templateExerciseGroupId: json['exerciseGroupId'] ,
      restTimed: Timed.fromSeconds(json['rest_timed']),
      barId: json['barId'] ,
      exerciseId: json['exerciseId'],
      templateId: json['templateId'],
    );
  }

  @override
  List<Object?> get props => [
    templateExerciseGroupId,
    restTimed,
    barId,
    exerciseId,
    templateId,
  ];
}