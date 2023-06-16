import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/timed.dart';
import '../database.dart';

@Entity(
  tableName: 'exercise',
  primaryKeys: [
    'exercise_id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['id'],
      entity: Bar,
    ),
  ],
)
class Exercise extends Equatable {
  const Exercise({
    this.exerciseId,
    required this.name,
    required this.muscle,
    required this.muscleGroup,
    required this.equipment,
    required this.videoPath,
    required this.timer,
    this.barId,
    this.fields = const [],
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'exercise_id')
  final int? exerciseId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'muscle')
  final Muscle muscle;

  @ColumnInfo(name: 'muscle_group')
  final MuscleGroup muscleGroup;

  @ColumnInfo(name: 'equipment')
  final Equipment equipment;

  @ColumnInfo(name: 'video_path')
  final String videoPath;

  @ColumnInfo(name: 'timer')
  final Timed timer;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  @ignore
  final List<ExerciseField> fields;

  @override
  List<Object?> get props => [
        exerciseId,
        name,
        muscle,
        muscleGroup,
        equipment,
        videoPath,
        timer,
        barId,
      ];

  static Exercise empty = Exercise(
    name: 'Empty',
    muscle: Muscle.trapezius,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.none,
    videoPath: 'Empty',
    timer: Timed.zero(),
  );

  Exercise copyWith({
    int? exerciseId,
    String? name,
    Muscle? muscle,
    MuscleGroup? muscleGroup,
    Equipment? equipment,
    String? videoPath,
    Timed? timer,
    int? barId,
    List<ExerciseField>? fields,
  }) {
    return Exercise(
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      muscle: muscle ?? this.muscle,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      equipment: equipment ?? this.equipment,
      videoPath: videoPath ?? this.videoPath,
      barId: barId ?? this.barId,
      timer: timer ?? this.timer,
      fields: fields ?? this.fields,
    );
  }
}
