import 'package:flutter_test/flutter_test.dart';
import 'package:maven/common/common.dart';
import 'package:maven/database/database.dart';
import 'package:maven/feature/exercise/exercise.dart';
import 'package:maven/feature/routine/service/service.dart';
import 'package:maven/feature/template/template.dart';
import 'package:maven/feature/workout/workout.dart';
import 'package:mocktail/mocktail.dart';

class MockRoutineDao extends Mock implements RoutineDao {}

class MockExerciseGroupDao extends Mock implements ExerciseGroupDao {}

class MockExerciseSetDao extends Mock implements ExerciseSetDao {}

class MockExerciseSetDataDao extends Mock implements ExerciseSetDataDao {}

class MockNoteDao extends Mock implements NoteDao {}

class MockWorkoutDataDao extends Mock implements WorkoutDataDao {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        const WorkoutData(id: 1, isActive: false, timeElapsed: Timed.zero(), routineId: 1));
  });

  group('RoutineService', () {
    late MockRoutineDao routineDao;
    late MockExerciseGroupDao exerciseGroupDao;
    late MockExerciseSetDao exerciseSetDao;
    late MockExerciseSetDataDao exerciseSetDataDao;
    late MockNoteDao noteDao;
    late MockWorkoutDataDao workoutDataDao;

    late RoutineService routineService;

    late Routine routine;
    late WorkoutData workoutData;

    setUp(() {
      routineDao = MockRoutineDao();
      exerciseGroupDao = MockExerciseGroupDao();
      exerciseSetDao = MockExerciseSetDao();
      exerciseSetDataDao = MockExerciseSetDataDao();
      noteDao = MockNoteDao();
      workoutDataDao = MockWorkoutDataDao();

      routineService = RoutineService(
        routineDao: routineDao,
        exerciseGroupDao: exerciseGroupDao,
        exerciseSetDao: exerciseSetDao,
        exerciseSetDataDao: exerciseSetDataDao,
        noteDao: noteDao,
        workoutDataDao: workoutDataDao,
      );

      routine = Routine(
        id: 1,
        name: 'Test Routine',
        type: RoutineType.workout,
        note: 'Test Note',
        timestamp: DateTime.now(),
      );
      workoutData = const WorkoutData(
        id: 1,
        isActive: true,
        timeElapsed: Timed.zero(),
        routineId: 1,
      );
    });

    test('getRoutine', () async {
      when(() => routineDao.get(1)).thenAnswer((_) async => routine);

      expect(await routineService.getRoutine(1), routine);
    });

    test('getRoutine throws exception if routine does not exist', () async {
      when(() => routineDao.get(1)).thenAnswer((_) async => null);

      expect(() async => await routineService.getRoutine(1), throwsException);
    });

    test('getWorkout', () async {
      ExerciseSet exerciseSet = ExerciseSet(
        id: 1,
        exerciseGroupId: 1,
        data: [],
        type: ExerciseSetType.regular,
        checked: false,
      );
      ExerciseGroup exerciseGroup = ExerciseGroup(
        id: 1,
        timer: Timed.zero(),
        weightUnit: WeightUnit.kilogram,
        distanceUnit: DistanceUnit.meter,
        barId: 1,
        routineId: 1,
        exerciseId: 1,
        sets: [exerciseSet],
      );

      when(() => workoutDataDao.getByIsActive()).thenAnswer((_) async => workoutData);

      when(() => routineDao.get(1)).thenAnswer((_) async => routine);

      when(() => exerciseGroupDao.getByRoutineId(1)).thenAnswer((_) async => [exerciseGroup]);

      when(() => exerciseSetDao.getByExerciseGroupId(1)).thenAnswer((_) async => [exerciseSet]);

      when(() => exerciseSetDataDao.getByExerciseSetId(1)).thenAnswer((_) async => []);

      when(() => noteDao.getByExerciseGroupId(1)).thenAnswer((_) async => []);

      expect(
        await routineService.getWorkout(),
        Workout(routine: routine, data: workoutData, exerciseGroups: [exerciseGroup]),
      );
    });

    test('getWorkout returns null if no workout is active', () async {
      when(() => workoutDataDao.getByIsActive()).thenAnswer((_) async => null);

      expect(await routineService.getWorkout(), null);
    });

    test('addWorkout', () async {
      when(() => routineDao.add(routine)).thenAnswer((_) async => 1);

      when(() => workoutDataDao.add(any())).thenAnswer((_) async => 1);

      expect(
        await routineService.addWorkout(routine),
        Workout(
          routine: routine.copyWith(id: 1),
          data: workoutData.copyWith(id: 1),
          exerciseGroups: const [],
        ),
      );
    });

    test('addWorkout throws exception if routine is not of type workout', () async {
      expect(
        () async => await routineService.addWorkout(routine.copyWith(type: RoutineType.session)),
        throwsException,
      );
    });

    test('removeWorkout', () async {
      when(() => routineDao.remove(routine)).thenAnswer((_) async => 1);

      await routineService.removeWorkout(Workout(
        routine: routine,
        data: workoutData,
        exerciseGroups: const [],
      ));

      verify(() => routineDao.remove(routine)).called(1);
    });

    test('removeWorkout throws exception if routine does not exist', () async {
      when(() => routineDao.remove(routine)).thenAnswer((_) async => 0);

      expect(
          () async => await routineService.removeWorkout(Workout(
                routine: routine,
                data: workoutData,
                exerciseGroups: const [],
              )),
          throwsException);
    });

    test('startTemplate', () async {
      Note note = const Note(
        id: 1,
        exerciseGroupId: 1,
        data: 'Test Note',
      );
      ExerciseSetData exerciseSetData = ExerciseSetData(
        id: 1,
        exerciseSetId: 1,
        value: '',
        fieldType: ExerciseFieldType.weight,
      );
      ExerciseSet exerciseSet = ExerciseSet(
        id: 1,
        exerciseGroupId: 1,
        data: [exerciseSetData],
        type: ExerciseSetType.regular,
        checked: false,
      );
      ExerciseGroup exerciseGroup = ExerciseGroup(
        id: 1,
        timer: Timed.zero(),
        weightUnit: WeightUnit.kilogram,
        distanceUnit: DistanceUnit.meter,
        barId: 1,
        routineId: 1,
        exerciseId: 1,
        notes: [note],
        sets: [exerciseSet],
      );
      Template template = Template(
        id: routine.id,
        name: routine.name,
        type: routine.type,
        note: routine.note,
        timestamp: routine.timestamp,
        exerciseGroups: [exerciseGroup],
      );

      registerFallbackValue(routine);
      registerFallbackValue(workoutData);
      registerFallbackValue(exerciseGroup);
      registerFallbackValue(note);
      registerFallbackValue(exerciseSet);
      registerFallbackValue(exerciseSetData);

      when(() => routineDao.add(any())).thenAnswer((_) async => 1);

      when(() => workoutDataDao.add(any())).thenAnswer((_) async => 1);

      when(() => exerciseGroupDao.add(any())).thenAnswer((_) async => 1);

      when(() => exerciseSetDao.add(any())).thenAnswer((_) async => 1);

      when(() => exerciseSetDataDao.add(any())).thenAnswer((_) async => 1);

      when(() => noteDao.add(any())).thenAnswer((_) async => 1);

      when(() => workoutDataDao.getByIsActive()).thenAnswer((_) async => workoutData);

      when(() => routineDao.get(1)).thenAnswer((_) async => routine);

      when(() => exerciseGroupDao.getByRoutineId(1)).thenAnswer((_) async => [exerciseGroup]);

      when(() => noteDao.getByExerciseGroupId(1)).thenAnswer((_) async => [note]);

      when(() => exerciseSetDao.getByExerciseGroupId(1)).thenAnswer((_) async => []);

      expect(
        await routineService.startTemplate(template),
        Workout(
          routine: template.copyWith(id: 1),
          data: workoutData.copyWith(id: 1),
          exerciseGroups: [exerciseGroup],
        ),
      );
    });
  });
}
