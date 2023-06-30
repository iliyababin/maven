import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'template',
  primaryKeys: [
    'id',
  ],
)
class Template extends Routine {
  const Template({
    super.id,
    required super.name,
    required super.description,
    required super.timestamp,
    required this.sort,
    this.exerciseGroups = const [],
  });

  @ColumnInfo(name: 'sort')
  final int sort;

  @ignore
  final List<TemplateExerciseGroup> exerciseGroups;

  @override
  Template copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? timestamp,
    int? sort,
    List<TemplateExerciseGroup>? exerciseGroups,
  }) {
    return Template(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      sort: sort ?? this.sort,
      exerciseGroups: exerciseGroups ?? this.exerciseGroups,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        timestamp,
        sort,
        exerciseGroups,
      ];
}
