import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../feature/exercise/model/exercise_equipment.dart';
import '../../feature/exercise/model/muscle.dart';
import '../../feature/exercise/model/muscle_group.dart';
import 'bar.dart';
import 'exercise_field.dart';

@Entity(
  tableName: 'exercise',
  primaryKeys: [
    'exercise_id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['bar_id'],
      parentColumns: ['bar_id'],
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
    this.barId,
    this.fields = const [],
  });

  @ColumnInfo(name: 'exercise_id')
  @PrimaryKey(autoGenerate: true)
  final int? exerciseId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'muscle')
  final Muscle muscle;

  @ColumnInfo(name: 'muscle_group')
  final MuscleGroup muscleGroup;

  @ColumnInfo(name: 'exercise_equipment')
  final Equipment equipment;

  @ColumnInfo(name: 'video_path')
  final String videoPath;

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
    barId,
  ];

  static Exercise empty = const Exercise(
    name: 'Empty',
    muscle: Muscle.trapezius,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.none,
    videoPath: 'Empty',
  );

  Exercise copyWith({
    int? exerciseId,
    String? name,
    Muscle? muscle,
    MuscleGroup? muscleGroup,
    Equipment? equipment,
    String? videoPath,
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
      fields: fields ?? this.fields,
    );
  }
}

List<Exercise> getDefaultExercises() => [
  const Exercise(
    exerciseId: 1,
    name: 'Barbell Squat',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'assets/exercises/videos/barbell_squat.mp4',
    barId: 1,
  ),
  const Exercise(
    exerciseId: 2,
    name: 'Barbell Bench Press',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.barbell,
    videoPath: 'assets/exercises/videos/barbell_bench_press.mp4',
    barId: 1,
  ),
  const Exercise(
    exerciseId: 3,
    name: 'Pull-up',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.bodyWeight,
    videoPath: 'assets/exercises/videos/pull_up.mp4',
  ),
  const Exercise(
    exerciseId: 4,
    name: 'Machine-assisted Triceps Dip',
    muscle: Muscle.tricepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.machine,
    videoPath: 'assets/exercises/videos/barbell_squat.mp4',
  ),
  const Exercise(
    exerciseId: 5,
    name: 'Dumbbell Curl',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.dumbbell,
    videoPath: 'assets/exercises/videos/dumbell_curl.mp4',
  ),
];
