import 'package:flutter_test/flutter_test.dart';
import 'package:maven/common/common.dart';
import 'package:maven/database/database.dart';
import 'package:maven/feature/exercise/exercise.dart';
import 'package:mocktail/mocktail.dart';

class MockExerciseDao extends Mock implements ExerciseDao {}

class MockExerciseFieldDao extends Mock implements ExerciseFieldDao {}

void main() {
  group('ExerciseService', () {
    late ExerciseDao exerciseDao;
    late ExerciseFieldDao exerciseFieldDao;

    setUp(() {
      exerciseDao = MockExerciseDao();
      exerciseFieldDao = MockExerciseFieldDao();
    });

    ExerciseService build() {
      return ExerciseService(
        exerciseDao: exerciseDao,
        exerciseFieldDao: exerciseFieldDao,
      );
    }

    Exercise exercise = const Exercise(
      name: 'Bench Press',
      equipment: Equipment.weighted,
      muscle: Muscle.pectoralisMajor,
      muscleGroup: MuscleGroup.chest,
      videoPath: 'na',
      timer: Timed.zero(),
      fields: <ExerciseField>[
        ExerciseField(
          exerciseId: 1,
          type: ExerciseFieldType.weight,
        ),
      ],
    );

    Exercise exerciseFromDB = const Exercise(
      id: 1,
      name: 'Bench Press',
      equipment: Equipment.weighted,
      muscle: Muscle.pectoralisMajor,
      muscleGroup: MuscleGroup.chest,
      videoPath: 'na',
      timer: Timed.zero(),
      fields: <ExerciseField>[
        ExerciseField(
          exerciseId: 1,
          type: ExerciseFieldType.weight,
        ),
      ],
    );

    test('add', () async {
      when(() => exerciseDao.add(exercise)).thenAnswer((_) async => 1);
      when(() => exerciseFieldDao.add(exercise.fields.first)).thenAnswer((_) async => 1);
      when(() => exerciseDao.get(1)).thenAnswer((_) async => exerciseFromDB);
      when(() => exerciseFieldDao.getByExerciseId(1))
          .thenAnswer((_) async => exerciseFromDB.fields);

      expect(await build().add(exercise), exerciseFromDB);
    });

    test('add throws exception if exercise has ID', () async {
      expect(() async => await build().add(exerciseFromDB), throwsException);
    });

    test('get', () async {
      when(() => exerciseDao.get(1)).thenAnswer((_) async => exerciseFromDB);
      when(() => exerciseFieldDao.getByExerciseId(1))
          .thenAnswer((_) async => exerciseFromDB.fields);

      expect(await build().get(1), exerciseFromDB);
    });

    test('get throws exception if exercise does not exist', () async {
      when(() => exerciseDao.get(1)).thenAnswer((_) async => null);

      expect(() async => await build().get(1), throwsException);
    });

    test('getAll', () async {
      when(() => exerciseDao.getAll()).thenAnswer((_) async => [exerciseFromDB, exerciseFromDB]);
      when(() => exerciseFieldDao.getByExerciseId(1))
          .thenAnswer((_) async => exerciseFromDB.fields);
      when(() => exerciseDao.get(1)).thenAnswer((_) async => exerciseFromDB);
      when(() => exerciseFieldDao.getByExerciseId(1))
          .thenAnswer((_) async => exerciseFromDB.fields);

      expect(await build().getAll(), [exerciseFromDB, exerciseFromDB]);
    });

    test('update', () async {
      when(() => exerciseDao.modify(exerciseFromDB)).thenAnswer((_) async => 1);
      when(() => exerciseDao.get(1)).thenAnswer((_) async => exerciseFromDB);
      when(() => exerciseFieldDao.getByExerciseId(1))
          .thenAnswer((_) async => exerciseFromDB.fields);
      when(() => exerciseFieldDao.add(exerciseFromDB.fields.first)).thenAnswer((_) async => 1);
      when(() => exerciseDao.get(1)).thenAnswer((_) async => exerciseFromDB);
      when(() => exerciseFieldDao.getByExerciseId(1))
          .thenAnswer((_) async => exerciseFromDB.fields);

      expect(await build().update(exerciseFromDB), exerciseFromDB);
    });

    test('update throws exception if exercise does not have ID', () async {
      expect(() async => await build().update(exercise), throwsException);
    });

    test('update throws exception if exercise was not updated', () async {
      when(() => exerciseDao.modify(exerciseFromDB)).thenAnswer((_) async => 0);

      expect(() async => await build().update(exerciseFromDB), throwsException);
    });
  });
}
