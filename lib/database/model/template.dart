import 'package:floor/floor.dart';

import '../../feature/exercise/model/exercise_bundle.dart';
import 'routine.dart';

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
    this.exerciseBundles = const [],
  });

  @ColumnInfo(name: 'sort')
  final int sort;

  @ignore
  final List<ExerciseBundle> exerciseBundles;

  @override
  Template copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? timestamp,
    int? sort,
    List<ExerciseBundle>? exerciseBundles,
  }) {
    return Template(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      sort: sort ?? this.sort,
      exerciseBundles: exerciseBundles ?? this.exerciseBundles,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        timestamp,
        sort,
        exerciseBundles,
      ];
}
