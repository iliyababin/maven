import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/exercise.dart';
import 'template.dart';

@Entity(
  tableName: 'template_exercise_group',
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_id'],
      parentColumns: ['exercise_id'],
      entity: Exercise
    ),
    ForeignKey(
        childColumns: ['template_id'],
        parentColumns: ['template_id'],
        entity: Template
    ),
  ]
)
class TemplateExerciseGroup extends Equatable {
  
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'template_exercise_group_id')
  final int? templateExerciseGroupId;

  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'template_id')
  final int templateId;

  TemplateExerciseGroup({
    this.templateExerciseGroupId,
    required this.exerciseId,
    required this.templateId,
  });

  factory TemplateExerciseGroup.fromMap(Map<String, dynamic> json) {
    return TemplateExerciseGroup(
      templateExerciseGroupId: json['exerciseGroupId'] ,
      exerciseId: json['exerciseId'],
      templateId: json['templateId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseGroupId': templateExerciseGroupId,
      'exerciseId': exerciseId,
      'templateId': templateId,
    };
  }

  @override
  List<Object?> get props => [
    templateExerciseGroupId,
    exerciseId,
    templateId,
  ];
}