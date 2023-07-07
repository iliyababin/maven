import '../../common/common.dart';
import '../../feature/exercise/exercise.dart';
import '../../feature/note/note.dart';
import '../database.dart';

class ExerciseGroupService {
  const ExerciseGroupService({
    required this.exerciseDao,
    required this.settingDao,
    required this.exerciseGroupDao,
    required this.exerciseSetDao,
    required this.exerciseSetDataDao,
    required this.noteDao,
  });

  final ExerciseDao exerciseDao;
  final SettingDao settingDao;
  final ExerciseGroupDao exerciseGroupDao;
  final ExerciseSetDao exerciseSetDao;
  final ExerciseSetDataDao exerciseSetDataDao;
  final NoteDao noteDao;

  Future<List<ExerciseGroup>> getByRoutineId(int routineId) async {
    List<ExerciseGroup> exerciseGroups = [];

    for (BaseExerciseGroup exerciseGroup in await exerciseGroupDao.getByRoutineId(routineId)) {
      List<Note> notes = [];
      for (BaseNote note in await noteDao.getByExerciseGroupId(exerciseGroup.id!)) {
        notes.add(Note(
          id: note.id,
          data: note.data,
          exerciseGroupId: note.exerciseGroupId,
        ));
      }

      List<ExerciseSet> exerciseSets = [];
      for (BaseExerciseSet exerciseSet in await exerciseSetDao.getByExerciseGroupId(exerciseGroup.id!)) {
        List<ExerciseSetData> exerciseSetData = [];
        for (BaseExerciseSetData baseExerciseSetData in await exerciseSetDataDao.getByExerciseSetId(exerciseSet.id!)) {
          exerciseSetData.add(ExerciseSetData(
            id: baseExerciseSetData.id,
            value: baseExerciseSetData.value,
            fieldType: baseExerciseSetData.fieldType,
            exerciseSetId: baseExerciseSetData.exerciseSetId,
          ));
        }

        exerciseSets.add(ExerciseSet(
          id: exerciseSet.id,
          type: exerciseSet.type,
          checked: exerciseSet.checked,
          exerciseGroupId: exerciseSet.exerciseGroupId,
          data: exerciseSetData,
        ));
      }

      exerciseGroups.add(ExerciseGroup(
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

  Future<double> getVolume(List<ExerciseGroup> exerciseGroups) async {
    double volume = 0;

    for(ExerciseGroup exerciseGroup in exerciseGroups){
      for(ExerciseSet exerciseSet in exerciseGroup.sets){
        double setVolume = 1;

        for(ExerciseSetData exerciseSetData in exerciseSet.data){
          if(exerciseGroup.weightUnit == WeightUnit.lbs) {
            setVolume *= exerciseSetData.valueAsDouble;
          } else {
            setVolume *= exerciseSetData.valueAsDouble * 0.45359237;
          }
        }
        volume += setVolume.toInt();
      }
    }

    BaseSetting? setting = await settingDao.getSetting();
    return setting!.weightUnit == WeightUnit.lbs ? volume : (volume * 0.45359237);
  }

  Future<Map<Muscle, double>> getMusclePercentages(List<ExerciseGroup> exerciseGroups) async {
    Map<Muscle, int> muscleCount = {};

    for(ExerciseGroup exerciseGroup in exerciseGroups){
      Exercise? exercise = await exerciseDao.getExercise(exerciseGroup.exerciseId);
      muscleCount[exercise!.muscle] = (muscleCount[exercise.muscle] ?? 0) + 1;
    }

    Map<Muscle, double> musclePercentages = {};
    for(Muscle muscle in muscleCount.keys){
      musclePercentages[muscle] = muscleCount[muscle]! / exerciseGroups.length;
    }

    return musclePercentages;
  }

  Timed getDuration(List<ExerciseGroup> exerciseGroups) {
    Timed duration = const Timed.zero();

    for(ExerciseGroup exerciseGroup in exerciseGroups){
      for(ExerciseSet exerciseSet in exerciseGroup.sets){
        duration = duration.add(exerciseGroup.timer);
      }
    }

    return duration;
  }
}
