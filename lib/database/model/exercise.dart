import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/timed.dart';
import '../database.dart';

@Entity(
  tableName: 'exercise',
  primaryKeys: [
    'id',
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
    this.id,
    required this.name,
    required this.muscle,
    required this.muscleGroup,
    required this.equipment,
    required this.videoPath,
    required this.timer,
    this.barId,
    this.weightUnit,
    this.distanceUnit,
    this.fields = const [],
  });

  const Exercise.empty()
      : id = null,
        name = 'Empty',
        muscle = Muscle.trapezius,
        muscleGroup = MuscleGroup.arms,
        equipment = Equipment.none,
        videoPath = 'Empty',
        timer = const Timed.zero(),
        barId = null,
        weightUnit = null,
        distanceUnit = null,
        fields = const [];

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

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

  @ColumnInfo(name: 'weight_unit')
  final WeightUnit? weightUnit;

  @ColumnInfo(name: 'distance_unit')
  final DistanceUnit? distanceUnit;

  @ignore
  final List<ExerciseField> fields;

  @override
  List<Object?> get props => [
        id,
        name,
        muscle,
        muscleGroup,
        equipment,
        videoPath,
        timer,
        barId,
        weightUnit,
        distanceUnit,
      ];

  Exercise copyWith({
    int? id,
    String? name,
    Muscle? muscle,
    MuscleGroup? muscleGroup,
    Equipment? equipment,
    String? videoPath,
    Timed? timer,
    int? barId,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    List<ExerciseField>? fields,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscle: muscle ?? this.muscle,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      equipment: equipment ?? this.equipment,
      videoPath: videoPath ?? this.videoPath,
      barId: barId ?? this.barId,
      timer: timer ?? this.timer,
      weightUnit: weightUnit ?? this.weightUnit,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      fields: fields ?? this.fields,
    );
  }
}
