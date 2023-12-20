/*
import 'package:flutter_test/flutter_test.dart';
import 'package:maven/common/common.dart';
import 'package:maven/database/database.dart';
import 'package:maven/feature/exercise/exercise.dart';
import 'package:mocktail/mocktail.dart';

class MockExerciseDao extends Mock implements ExerciseDao {}

class MockExerciseFieldDao extends Mock implements ExerciseFieldDao {}

void main() {
  group('exercise service', () {
    late ExerciseDao exerciseDao;
    late ExerciseFieldDao exerciseFieldDao;
    late ExerciseService exerciseService;

    setUp(() {
      exerciseDao = MockExerciseDao();
      exerciseFieldDao = MockExerciseFieldDao();
      exerciseService = ExerciseService(
        exerciseDao: exerciseDao,
        exerciseFieldDao: exerciseFieldDao,
      );
      registerFallbackValue(const ExerciseField(
        type: ExerciseFieldType.assisted,
        exerciseId: -1,
      ));
    });

    /// Test that the service can add an exercise with fields
    test('add', () {
      Exercise orgExercise = const Exercise.empty().copyWith(
        fields: [
          const ExerciseField(
            exerciseId: 1,
            type: ExerciseFieldType.assisted,
          ),
          const ExerciseField(
            exerciseId: 2,
            type: ExerciseFieldType.weighted,
          ),
        ],
      );

      Exercise newExercise = const Exercise.empty().copyWith(
        id: 1,
        isCustom: true,
        fields: [
          const ExerciseField(
            exerciseId: 1,
            type: ExerciseFieldType.assisted,
          ),
          const ExerciseField(
            exerciseId: 2,
            type: ExerciseFieldType.weighted,
          ),
        ],
      );

      when(() => exerciseDao.add(orgExercise))
          .thenAnswer((_) async => newExercise.id!);
      when(() => exerciseDao.getExercise(newExercise.id!))
          .thenAnswer((_) async => newExercise);
      when(() => exerciseFieldDao.add(any())).thenAnswer((_) async => -1);
      when(() => exerciseFieldDao.getByExerciseId(newExercise.id!)).thenAnswer(
        (_) async => newExercise.fields,
      );

      exerciseService.add(orgExercise).then((value) {
        expect(value, newExercise);
        expect(value.fields, newExercise.fields);
      });
    });

    /// Test that the service throws an error when trying to add an exercise with an id
    test('add with id', () {
      Exercise exercise = const Exercise.empty().copyWith(id: 1);

      expect(() => exerciseService.add(exercise), throwsFormatException);
    });

    /// Test that the service can update an exercise with fields
    test('update', () {
      Exercise orgExercise = const Exercise.empty().copyWith(
        id: 1,
        isCustom: true,
        fields: [
          const ExerciseField(
            id: 1,
            exerciseId: 1,
            type: ExerciseFieldType.assisted,
          ),
          const ExerciseField(
            id: 2,
            exerciseId: 1,
            type: ExerciseFieldType.weighted,
          ),
        ],
      );

      Exercise newExercise = const Exercise.empty().copyWith(
        id: 1,
        isCustom: true,
        fields: [
          const ExerciseField(
            id: 1,
            exerciseId: 1,
            type: ExerciseFieldType.assisted,
          ),
          const ExerciseField(
            id: 2,
            exerciseId: 1,
            type: ExerciseFieldType.weighted,
          ),
        ],
      );

      when(() => exerciseDao.updateExercise(orgExercise))
          .thenAnswer((_) async => 1);
      when(() => exerciseDao.getExercise(newExercise.id!))
          .thenAnswer((_) async => newExercise);
      when(() => exerciseFieldDao.add(any())).thenAnswer((_) async => -1);
      when(() => exerciseFieldDao.getByExerciseId(newExercise.id!)).thenAnswer(
        (_) async => newExercise.fields,
      );

      exerciseService.update(orgExercise).then((value) {
        expect(value, newExercise);
        expect(value.fields, newExercise.fields);
      });
    });
  });
}
*/
