import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../feature/exercise/model/exercise_equipment.dart';
import '../../feature/exercise/model/exercise_type.dart';
import '../../feature/exercise/model/muscle.dart';
import '../../feature/exercise/model/muscle_group.dart';
import 'bar.dart';

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
  ]
)
class Exercise extends Equatable {
  const Exercise({
    this.exerciseId,
    required this.name,
    required this.muscle,
    required this.muscleGroup,
    required this.exerciseType,
    required this.exerciseEquipment,
    this.barId,
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

  @ColumnInfo(name: 'exercise_type')
  final ExerciseType exerciseType;

  @ColumnInfo(name: 'exercise_equipment')
  final ExerciseEquipment exerciseEquipment;

  @ColumnInfo(name: 'bar_id')
  final int? barId;

  @override
  List<Object?> get props => [
    exerciseId,
    name,
    muscle,
    muscleGroup,
    exerciseType,
    exerciseEquipment,
    barId,
  ];
}

List<Exercise> getDefaultExercises() => [
  const Exercise(
    name: 'Barbell Squat',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    exerciseType: ExerciseTypes.weightAndReps,
    exerciseEquipment: ExerciseEquipment.barbell,
    barId: 1,
  ),
  const Exercise(
    name: 'Barbell Bench Press',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    exerciseType: ExerciseTypes.weightAndReps,
    exerciseEquipment: ExerciseEquipment.barbell,
    barId: 1,
  ),
  const Exercise(
    name: 'Pull-up',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    exerciseType: ExerciseTypes.bodyweightReps,
    exerciseEquipment: ExerciseEquipment.bodyWeight,
  ),
  const Exercise(
    name: 'Machine-assisted Triceps Dip',
    muscle: Muscle.tricepsBrachii,
    muscleGroup: MuscleGroup.arms,
    exerciseType: ExerciseTypes.assistedBodyweight,
    exerciseEquipment: ExerciseEquipment.machine,
  ),
  const Exercise(
    name: 'Dumbbell Curl',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    exerciseType: ExerciseTypes.weightAndReps,
    exerciseEquipment: ExerciseEquipment.dumbbell,
  ),
];
