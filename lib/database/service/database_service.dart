import '../../common/common.dart';
import '../../feature/exercise/exercise.dart';
import '../database.dart';

class DatabaseService {
  const DatabaseService({
    required this.exerciseDao,
    required this.settingDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
  });

  final ExerciseDao exerciseDao;
  final SettingsDao settingDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;

  Future<List<ExerciseGroupDto>> getByRoutineId(int routineId) async {
    List<ExerciseGroupDto> exerciseGroups = [];
    for (BaseExerciseGroup exerciseGroup in await exerciseGroupDao.getByRoutineId(routineId)) {
      List<Note> notes = [];
      for (Note note in await noteDao.getByExerciseGroupId(exerciseGroup.id!)) {
        notes.add(Note(
          id: note.id,
          data: note.data,
          exerciseGroupId: note.exerciseGroupId,
        ));
      }

      List<ExerciseSetDto> exerciseSets = [];
      for (BaseExerciseSet exerciseSet
          in await exerciseSetDao.getByExerciseGroupId(exerciseGroup.id!)) {
        List<ExerciseSetDataDto> exerciseSetData = [];
        for (BaseExerciseSetData baseExerciseSetData
            in await exerciseSetDataDao.getByExerciseSetId(exerciseSet.id!)) {
          exerciseSetData.add(ExerciseSetDataDto(
            id: baseExerciseSetData.id,
            value: baseExerciseSetData.value,
            fieldType: baseExerciseSetData.fieldType,
            exerciseSetId: baseExerciseSetData.exerciseSetId,
          ));
        }

        exerciseSets.add(ExerciseSetDto(
          id: exerciseSet.id,
          type: exerciseSet.type,
          checked: exerciseSet.checked,
          exerciseGroupId: exerciseSet.exerciseGroupId,
          data: exerciseSetData,
        ));
      }

      exerciseGroups.add(ExerciseGroupDto(
        id: exerciseGroup.id,
        timer: exerciseGroup.timer,
        weightUnit: exerciseGroup.weightUnit,
        distanceUnit: exerciseGroup.distanceUnit,
        exerciseId: exerciseGroup.exerciseId,
        barId: exerciseGroup.barId,
        routineId: exerciseGroup.routineId,
        notes: notes,
        sets: exerciseSets,
      ));
    }

    return exerciseGroups;
  }

  Future<double> getVolume(List<ExerciseGroupDto> exerciseGroups) async {
    double pounds = 0;

    for (ExerciseGroupDto exerciseGroup in exerciseGroups) {
      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        double setPounds = 1;

        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          if (exerciseSetData.fieldType == ExerciseFieldType.weight) {
            if (exerciseGroup.weightUnit == WeightUnit.pound) {
              setPounds *= exerciseSetData.valueAsDouble;
            } else if (exerciseGroup.weightUnit == WeightUnit.kilogram) {
              setPounds *= exerciseSetData.valueAsDouble * 2.20462262;
            }
          } else if (exerciseSetData.fieldType == ExerciseFieldType.reps) {
            setPounds *= exerciseSetData.valueAsDouble;
          }
        }
        pounds += setPounds;
      }
    }
    return pounds;
  }

  Future<Map<Muscle, double>> getMusclePercentages(List<ExerciseGroupDto> exerciseGroups) async {
    Map<Muscle, int> muscleCount = {};

    for (ExerciseGroupDto exerciseGroup in exerciseGroups) {
      Exercise? exercise = await exerciseDao.get(exerciseGroup.exerciseId);
      muscleCount[exercise!.muscle] = (muscleCount[exercise.muscle] ?? 0) + 1;
    }

    Map<Muscle, double> musclePercentages = {};
    for (Muscle muscle in muscleCount.keys) {
      musclePercentages[muscle] = muscleCount[muscle]! / exerciseGroups.length;
    }

    return musclePercentages;
  }

  Timed getDuration(List<ExerciseGroupDto> exerciseGroups) {
    Timed duration = const Timed.zero();

    for (ExerciseGroupDto exerciseGroup in exerciseGroups) {
      for (ExerciseSetDto exerciseSet in exerciseGroup.sets) {
        duration = duration.add(exerciseGroup.timer);
        for (ExerciseSetDataDto exerciseSetData in exerciseSet.data) {
          if (exerciseSetData.fieldType == ExerciseFieldType.duration) {
            duration = duration.add(Timed.fromSeconds(exerciseSetData.valueAsDouble.toInt()));
          }
        }
      }
    }

    return duration;
  }

  static int getWeekStreak(List<DateTime> dateTimes) {
    if (dateTimes.isEmpty) return 0;

    List<DateTime> dates = dateTimes.map((e) => DateTime(e.year, e.month, e.day)).toList();
    dates.sort((a, b) => b.compareTo(a));

    if (dates.first.isBefore(DateTime.now().subtract(const Duration(days: 7)))) return 0;

    int weekStreak = 1;

    DateTime completeByDate = dates.first.subtract(const Duration(days: 7));
    DateTime incrementDate = dates.first.subtract(const Duration(days: 7));

    for (DateTime date in dates) {
      if (date.isBefore(completeByDate)) break;

      completeByDate = date.subtract(const Duration(days: 7));
      if (date.isBefore(incrementDate)) {
        weekStreak++;
        incrementDate = date.subtract(const Duration(days: 7));
      }
    }
    return weekStreak;
  }
}
