import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'template_exercise_group_note',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_group_id'],
      parentColumns: ['id'],
      entity: TemplateExerciseGroup,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TemplateExerciseGroupNote extends Note {
  const TemplateExerciseGroupNote({
    super.id,
    required super.data,
    required super.exerciseGroupId,
  });

  @override
  TemplateExerciseGroupNote copyWith({
    int? id,
    String? data,
    int? exerciseGroupId,
  }) {
    return TemplateExerciseGroupNote(
      id: id ?? this.id,
      data: data ?? this.data,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
    );
  }
}