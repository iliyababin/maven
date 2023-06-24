import 'package:floor/floor.dart';
import 'package:maven/feature/exercise/model/exercise_bundle.dart';

import '../database.dart';

@Entity(
  tableName: 'program_template',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: [
        'folder_id',
      ],
      parentColumns: [
        'id',
      ],
      entity: ProgramFolder,
    ),
  ],
)
class ProgramTemplate extends Routine {
  const ProgramTemplate({
    super.id,
    required super.name,
    required super.description,
    required super.timestamp,
    required this.day,
    required this.complete,
    required this.folderId,
    this.exerciseBundles = const [],
  });

  @ColumnInfo(name: 'day')
  final Day day;

  @ColumnInfo(name: 'complete')
  final bool complete;

  @ColumnInfo(name: 'folder_id')
  final int folderId;

  @ignore
  final List<ExerciseBundle> exerciseBundles;

  @override
  ProgramTemplate copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? timestamp,
    Day? day,
    bool? complete,
    int? folderId,
    List<ExerciseBundle>? exerciseBundles,
  }) {
    return ProgramTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      day: day ?? this.day,
      complete: complete ?? this.complete,
      folderId: folderId ?? this.folderId,
      exerciseBundles: exerciseBundles ?? this.exerciseBundles,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        timestamp,
        day,
        complete,
        folderId,
        exerciseBundles,
      ];
}
