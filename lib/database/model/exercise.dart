import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../common/model/timed.dart';
import '../database.dart';

/// Represents an exercise.
///
/// Example usage:
/// ```dart
/// Exercise exercise = Exercise(
///   exerciseId: 1,
///   name: 'Barbell Squat',
///   muscle: Muscle.quadriceps,
///   muscleGroup: MuscleGroup.legs,
///   equipment: Equipment.barbell,
///   videoPath: 'assets/exercises/videos/barbell_squat.mp4',
///   timer: Timed.zero(),
///   barId: 1,
/// );
/// ```
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
  /// Creates a new instance of the [Exercise] class.
  ///
  /// The [barId] and [fields] parameters are optional and default to null
  /// and an empty list, respectively.
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

  /// The ID of the exercise.
  @ColumnInfo(name: 'exercise_id')
  @PrimaryKey(autoGenerate: true)
  final int? exerciseId;

  /// The name of the exercise.
  final String name;

  /// The primary muscle targeted by the exercise.
  final Muscle muscle;

  /// The muscle group that the exercise belongs to.
  final MuscleGroup muscleGroup;

  /// The equipment required for the exercise.
  final Equipment equipment;

  /// The file path to the exercise video.
  final String videoPath;

  /// The timer configuration for the exercise.
  final Timed timer;

  /// The ID of the bar associated with the exercise.
  ///
  /// If the exercise does not require a bar, this value may be null.
  @ColumnInfo(name: 'bar_id')
  final int? barId;

  /// Convenience field for storing additional information about the exercise.
  @ignore
  final List<ExerciseField> fields;

  /// Returns a list of [Object]s that are used to determine equality of two [Exercise] instances.
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

  /// A static empty [Exercise] instance.
  ///
  /// This instance can be used as a placeholder or default value.
  static Exercise empty = Exercise(
    name: 'Empty',
    muscle: Muscle.trapezius,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.none,
    videoPath: 'Empty',
    timer: Timed.zero(),
  );

  /// Creates a copy of the current [Exercise] instance with some fields replaced.
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