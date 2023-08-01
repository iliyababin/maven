import '../../common/model/model.dart';
import '../../feature/transfer/transfer.dart';
import '../database.dart';

/// Returns a list of default exercises.
///
/// The list contains pre-defined [Exercise] instances that can be used as a starting point
/// or default set of exercises.
List<Exercise> getDefaultExercises() => [
  const Exercise(
    id: 1,
    name: 'Ab Wheel',
    muscle: Muscle.iliopsoas,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.wheelRoller,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Ab Wheel',
      ),
    ],
  ),
  const Exercise(
    id: 2,
    name: 'Arnold Press (Dumbbell)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Arnold Press (Dumbbell)',
      ),
    ],
  ),
  const Exercise(
    id: 3,
    name: 'Around the World',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Around the World',
      ),
    ],
  ),
  const Exercise(
    id: 4,
    name: 'Back Extension',
    muscle: Muscle.erectorSpinae,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Back Extension',
      ),
    ],
  ),
  const Exercise(
    id: 5,
    name: 'Back Extension (Machine)',
    muscle: Muscle.erectorSpinae,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Back Extension (Machine)',
      ),
    ],
  ),
  const Exercise(
    id: 6,
    name: 'Ball Slams',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.ball,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Ball Slams',
      ),
    ],
  ),
  const Exercise(
    id: 7,
    name: 'Battle Ropes',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.rope,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    distanceUnit: DistanceUnit.feet,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.distance,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Battle Ropes',
      ),
    ],
  ),
  const Exercise(
    id: 8,
    name: 'Bench Dip',
    muscle: Muscle.tricepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.bench,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weighted,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        type: TransferType.strong,
        name: 'Bench Dip',
      ),
    ],
  ),
  const Exercise(
    id: 9,
    name: 'Bench Press (Barbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bench Press (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 10,
    name: 'Bench Press (Cable)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bench Press (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 11,
    name: 'Bench Press (Dumbbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bench Press (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 12,
    name: 'Bench Press (Smith Machine)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bench Press (Smith Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 13,
    name: 'Bench Press Close Grip (Barbell)',
    muscle: Muscle.tricepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bench Press Close Grip (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 14,
    name: 'Bench Press Wide Grip (Barbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bench Press Wide Grip (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 15,
    name: 'Bent-over One Arm Row (Dumbbell)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bent-over One Arm Row (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 16,
    name: 'Bent-over Row (Band)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.band,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bent-over Row (Band)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 17,
    name: 'Bent-over Row (Barbell)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bent-over Row (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 18,
    name: 'Bent-over Row (Dumbbell)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bent-over Row (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 19,
    name: 'Bent-over Row - Underhand (Barbell)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bent-over Row - Underhand (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 20,
    name: 'Bicep Curl (Barbell)',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bicep Curl (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 21,
    name: 'Bicep Curl (Cable)',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bicep Curl (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 22,
    name: 'Bicep Curl (Dumbbell)',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bicep Curl (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 23,
    name: 'Bicep Curl (Machine)',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bicep Curl (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 24,
    name: 'Bicycle Crunch',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bicycle Crunch',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 25,
    name: 'Box Jump',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Box Jump',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 26,
    name: 'Box Squat (Barbell)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Box Squat (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 27,
    name: 'Bulgarian Split Squat (Dumbbell)',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Bulgarian Split Squat (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 28,
    name: 'Burpee',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Burpee',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 29,
    name: 'Cable Crossover',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cable Crossover',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 30,
    name: 'Cable Crunch',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cable Crunch',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 31,
    name: 'Cable Kickback',
    muscle: Muscle.tricepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cable Kickback',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 32,
    name: 'Cable Pull Through',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cable Pull Through',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 33,
    name: 'Cable Twist',
    muscle: Muscle.obliques,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cable Twist',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 34,
    name: 'Calf Press on Leg Press',
    muscle: Muscle.gastrocnemius,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Calf Press on Leg Press',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 35,
    name: 'Calf Press on Seated Leg Press',
    muscle: Muscle.gastrocnemius,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Calf Press on Seated Leg Press',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 36,
    name: 'Chest Dip',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weighted,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chest Dip',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 37,
    name: 'Chest Dip (Assisted)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.assisted,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chest Dip (Assisted)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 38,
    name: 'Chest Fly (Machine)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chest Fly (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 39,
    name: 'Chest Fly (Band)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.band,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chest Fly (Band)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 40,
    name: 'Chest Fly (Dumbbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chest Fly (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 41,
    name: 'Chest Press (Band)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.band,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chest Press (Band)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 42,
    name: 'Chest Press (Machine)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chest Press (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 43,
    name: 'Chin Up',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weighted,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chin Up',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 44,
    name: 'Chin Up (Assisted)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.assisted,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Chin Up (Assisted)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 45,
    name: 'Clean (Barbell)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Clean (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 46,
    name: 'Clean and Jerk (Barbell)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Clean and Jerk (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 47,
    name: 'Concentration Curl (Dumbbell)',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Concentration Curl (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 48,
    name: 'Cross Body Crunch',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cross Body Crunch',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 49,
    name: 'Crunch',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Crunch',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 50,
    name: 'Crunch (Machine)',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Crunch (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 51,
    name: 'Crunch (Stability Ball)',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.ball,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Crunch (Stability Ball)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 52,
    name: 'Cycling',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed.zero(),
    distanceUnit: DistanceUnit.mile,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.distance,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cycling (Indoor)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 53,
    name: 'Cycling (Indoor)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed.zero(),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.distance,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Cycling',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 54,
    name: 'Deadlift (Band)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.band,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Deadlift (Band)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 55,
    name: 'Deadlift (Barbell)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Deadlift (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 56,
    name: 'Deadlift (Dumbbell)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Deadlift (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 57,
    name: 'Deadlift (Smith Machine)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Deadlift (Smith Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 58,
    name: 'Deadlift High Pull (Barbell)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Deadlift High Pull (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 59,
    name: 'Decline Bench Press (Barbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Decline Bench Press (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 60,
    name: 'Decline Bench Press (Dumbbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Decline Bench Press (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 61,
    name: 'Decline Bench Press (Smith Machine)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Decline Bench Press (Smith Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 62,
    name: 'Decline Crunch',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.bench,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Decline Crunch',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 63,
    name: 'Deficit Deadlift (Barbell)',
    muscle: Muscle.erectorSpinae,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Deficit Deadlift (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 64,
    name: 'Elliptical Trainer',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed.zero(),
    distanceUnit: DistanceUnit.mile,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.distance,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Elliptical Trainer',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 65,
    name: 'Face Pull (Cable)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Face Pull (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 66,
    name: 'Flat Knee Raise',
    muscle: Muscle.iliopsoas,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Flat Knee Raise',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 67,
    name: 'Flat Leg Raise',
    muscle: Muscle.iliopsoas,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Flat Leg Raise',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 68,
    name: 'Floor Press (Barbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Floor Press (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 69,
    name: 'Front Raise (Band)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.band,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Front Raise (Band)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 70,
    name: 'Front Raise (Barbell)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Front Raise (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 71,
    name: 'Front Raise (Cable)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Front Raise (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 72,
    name: 'Front Raise (Dumbbell)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Front Raise (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 73,
    name: 'Front Raise (Plate)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.plate,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Front Raise (Plate)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 74,
    name: 'Front Squat (Barbell)',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Front Squat (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 75,
    name: 'Glute Ham Raise',
    muscle: Muscle.hamstrings,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Glute Ham Raise',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 76,
    name: 'Glute Kickback (Machine)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Glute Kickback (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 77,
    name: 'Goblet Squat (Kettlebell)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.kettleBell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Goblet Squat (Kettlebell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 78,
    name: 'Good Morning (Barbell)',
    muscle: Muscle.hamstrings,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Good Morning (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 79,
    name: 'Hack Squat',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hack Squat',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 80,
    name: 'Hack Squat (Barbell)',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hack Squat (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 81,
    name: 'Hammer Curl (Band)',
    muscle: Muscle.brachioradialis,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.band,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hammer Curl (Band)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 82,
    name: 'Hammer Curl (Cable)',
    muscle: Muscle.brachioradialis,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hammer Curl (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 83,
    name: 'Hammer Curl (Dumbbell)',
    muscle: Muscle.brachioradialis,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hammer Curl (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 84,
    name: 'Handstand Push-Up',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.bodyWeight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Handstand Push-Up',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 85,
    name: 'Hang Clean (Barbell)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hang Clean (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 86,
    name: 'Hang Snatch (Dumbbell)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hang Snatch (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 87,
    name: 'Hanging knee Raise',
    muscle: Muscle.iliopsoas,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hanging knee Raise',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 88,
    name: 'Hanging Leg Raise',
    muscle: Muscle.iliopsoas,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hanging Leg Raise',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 89,
    name: 'High Knee Skips',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.bodyWeight,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'High Knee Skips',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 90,
    name: 'Hiking',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.bodyWeight,
    videoPath: 'VIDEOPATH',
    timer: Timed.zero(),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.distance,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hiking',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 91,
    name: 'Hip Abductor (Machine)',
    muscle: Muscle.adductors,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hip Abductor (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 92,
    name: 'Hip Adductor (Machine)',
    muscle: Muscle.adductors,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hip Adductor (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 93,
    name: 'Hip Thrust (Barbell)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hip Thrust (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 94,
    name: 'Hip Thrust (Bodyweight)',
    muscle: Muscle.gluteus,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.bodyWeight,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.bodyWeight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Hip Thrust (Bodyweight)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 95,
    name: 'Incline Bench Press (Barbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Bench Press (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 96,
    name: 'Incline Bench Press (Cable)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Bench Press (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 97,
    name: 'Incline Bench Press (Dumbbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Bench Press (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 98,
    name: 'Incline Bench Press (Smith Machine)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Bench Press (Smith Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 99,
    name: 'Incline Chest Fly (Dumbbell)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Chest Fly (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 100,
    name: 'Incline Chest Press (Machine)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Chest Press (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 101,
    name: 'Incline Curl (Dumbbell)',
    muscle: Muscle.bicepsBrachii,
    muscleGroup: MuscleGroup.arms,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Curl (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 102,
    name: 'Incline Row (Dumbbell)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Incline Row (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 103,
    name: 'Inverted row (Bodyweight)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.bodyWeight,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.bodyWeight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Inverted row (Bodyweight)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 104,
    name: 'Iso-Lateral Chest Press (Machine)',
    muscle: Muscle.pectoralisMajor,
    muscleGroup: MuscleGroup.chest,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Iso-Lateral Chest Press (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 105,
    name: 'Iso-Lateral Row (Machine)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Iso-Lateral Row (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 106,
    name: 'Jackknife Sit-Up',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Jackknife Sit-Up',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 107,
    name: 'Jump Rope',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed.zero(),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Jump Rope',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 108,
    name: 'Jump Shrug (Barbell)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Jump Shrug (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 109,
    name: 'Jump Squat',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Jump Squat',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 110,
    name: 'Jumping Jack',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Jumping Jack',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 111,
    name: 'Kettlebell Swing',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.kettleBell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Kettlebell Swing',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 112,
    name: 'Kettlebell Turkish Get-Up',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.kettleBell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Kettlebell Turkish Get-Up',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 113,
    name: 'Kipping Pull-Up',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.bodyWeight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Kipping Pull-Up',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 114,
    name: 'Knee Raise (Captain\'s Chair)',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Knee Raise (Captain\'s Chair)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 115,
    name: 'Kneeling Pull-Down (Band)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.band,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Kneeling Pull-Down (Band)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 116,
    name: 'Knees to Elbows',
    muscle: Muscle.rectusAbdominis,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.bodyWeight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Knees to Elbows',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 117,
    name: 'Lat Pulldown (Cable)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lat Pulldown (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 118,
    name: 'Lat Pulldown (Machine)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lat Pulldown (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 119,
    name: 'Lat Pulldown (Single Arm)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lat Pulldown (Single Arm)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 120,
    name: 'Lat Pulldown - Underhand (Cable)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lat Pulldown - Underhand (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 121,
    name: 'Lat Pulldown - Wide Grip (Cable)',
    muscle: Muscle.latissimusDorsi,
    muscleGroup: MuscleGroup.back,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lat Pulldown - Wide Grip (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 122,
    name: 'Lateral Box Jump',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.bodyWeight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lateral Box Jump',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 123,
    name: 'Lateral Raise (Cable)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lateral Raise (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 124,
    name: 'Lateral Raise (Dumbbell)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lateral Raise (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 125,
    name: 'Lateral Raise (Machine)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lateral Raise (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 126,
    name: 'Leg Extension (Machine)',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Leg Extension (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 127,
    name: 'Leg Press',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
      second: 0,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Leg Press',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 128,
    name: 'Lunge (Barbell)',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
      second: 0,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lunge (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 129,
    name: 'Lunge (Bodyweight)',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.bodyWeight,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
      second: 0,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.bodyWeight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lunge (Bodyweight)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 130,
    name: 'Lunge (Dumbbell)',
    muscle: Muscle.quadriceps,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weighted,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lunge (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 131,
    name: 'Lying Leg Curl (Machine)',
    muscle: Muscle.hamstrings,
    muscleGroup: MuscleGroup.legs,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Lying Leg Curl (Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 132,
    name: 'Mountain Climber',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.duration,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Mountain Climber',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise (
    id: 133,
    name: 'Muscle Up',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weighted,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Muscle Up',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 134,
    name: 'Oblique Crunch',
    muscle: Muscle.obliques,
    muscleGroup: MuscleGroup.core,
    equipment: Equipment.none,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    fields: [
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Oblique Crunch',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 135,
    name: 'Overhead Press (Barbell)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      )
    ],
    conversions: [
      ExerciseConversion(
        name: 'Overhead Press (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 136,
    name: 'Overhead Press (Cable)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.cable,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Overhead Press (Cable)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 137,
    name: 'Overhead Press (Dumbbell)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.dumbbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 1,
      second: 30,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      )
    ],
    conversions: [
      ExerciseConversion(
        name: 'Overhead Press (Dumbbell)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 138,
    name: 'Overhead Press (Smith Machine)',
    muscle: Muscle.deltoid,
    muscleGroup: MuscleGroup.shoulders,
    equipment: Equipment.machine,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Overhead Press (Smith Machine)',
        type: TransferType.strong,
      ),
    ],
  ),
  const Exercise(
    id: 139,
    name: 'Overhead Squat (Barbell)',
    muscle: Muscle.fullBody,
    muscleGroup: MuscleGroup.fullBody,
    equipment: Equipment.barbell,
    videoPath: 'VIDEOPATH',
    timer: Timed(
      minute: 3,
    ),
    weightUnit: WeightUnit.pound,
    fields: [
      ExerciseField(
        type: ExerciseFieldType.weight,
        exerciseId: -1,
      ),
      ExerciseField(
        type: ExerciseFieldType.reps,
        exerciseId: -1,
      ),
    ],
    conversions: [
      ExerciseConversion(
        name: 'Overhead Squat (Barbell)',
        type: TransferType.strong,
      ),
    ],
  ),
];
