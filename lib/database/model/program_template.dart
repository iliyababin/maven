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
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class ProgramTemplate extends Routine {
  const ProgramTemplate({
    super.id,
    required super.name,
    required super.note,
    required super.timestamp,
    required this.day,
    required this.complete,
    required this.folderId,
    this.exerciseBundles = const [],
    required super.type,
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
    String? note,
    DateTime? timestamp,
    Day? day,
    bool? complete,
    int? folderId,
    List<ExerciseBundle>? exerciseBundles,
    int? sort,
    RoutineType? type,
  }) {
    return ProgramTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      day: day ?? this.day,
      complete: complete ?? this.complete,
      folderId: folderId ?? this.folderId,
      exerciseBundles: exerciseBundles ?? this.exerciseBundles,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        note,
        timestamp,
        day,
        complete,
        folderId,
        exerciseBundles,
      ];
}
