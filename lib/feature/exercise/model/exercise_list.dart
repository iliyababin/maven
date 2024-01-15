import '../../../database/database.dart';
import '../exercise.dart';

class ExerciseList {
  static const int blank = -1;

  final List<ExerciseGroupDto> _exercises;

  ExerciseList(
    List<ExerciseGroupDto>? exercises,
  ) : _exercises = exercises ?? [];

  int getLength() {
    return _exercises.length;
  }

  void addExerciseGroup(Exercise exercise) {
    ExerciseGroupDto exerciseGroup = ExerciseGroupDto(
      timer: exercise.timer,
      weightUnit: exercise.weightUnit,
      distanceUnit: exercise.distanceUnit,
      exerciseId: exercise.id!,
      barId: exercise.barId,
      routineId: blank,
      sets: [
        ExerciseSetDto(
          checked: false,
          type: ExerciseSetType.regular,
          exerciseGroupId: blank,
          data: exercise.fields.map((field) {
            return ExerciseSetDataDto(
              value: '',
              fieldType: field.type,
              exerciseSetId: blank,
            );
          }).toList(),
        ),
      ],
    );

    _exercises.add(exerciseGroup);
  }

  void removeExerciseGroup(int index) {
    _exercises.removeAt(index);
  }

  void addExerciseSet(int index) {
    ExerciseGroupDto exerciseGroup = _exercises[index];
    ExerciseSetDto exerciseSet = ExerciseSetDto(
      checked: false,
      type: ExerciseSetType.regular,
      exerciseGroupId: blank,
      data: exerciseGroup.sets.last.data.map((data) {
        return data.copyWith();
      }).toList(),
    );

    exerciseGroup.sets.add(exerciseSet);
  }

  ExerciseGroupDto getExerciseGroup(int index) {
    return _exercises[index];
  }

  void updateExerciseSet(ExerciseSetDto value, int index, int index2) {
    _exercises[index].sets[index2] = value;
  }

  void removeExerciseSet(int index, int index2) {
    _exercises[index].sets.removeAt(index2);
  }

  void updateExerciseGroup(ExerciseGroupDto value, int index) {
    _exercises[index] = value;
  }

  // figure some shit out for this temp solution
  ExerciseList deepCopy() {
    return ExerciseList(_exercises
        .map(
          (exerciseGroup) => exerciseGroup.copyWith(
            sets: exerciseGroup.sets
                .map(
                  (exerciseSet) => exerciseSet.copyWith(
                    data: exerciseSet.data
                        .map(
                          (exerciseSetData) => exerciseSetData.copyWith(),
                        )
                        .toList(),
                  ),
                )
                .toList(),
            notes: exerciseGroup.notes
                .map(
                  (note) => note.copyWith(),
                )
                .toList(),
          ),
        )
        .toList());
  }
}
