import 'package:Maven/database/model/exercise.dart';
import 'package:Maven/database/model/workout.dart';
import 'package:Maven/database/model/workout_exercise_set.dart';
import 'package:Maven/feature/exercise/dao/exercise_dao.dart';
import 'package:Maven/feature/exercise/model/exercise_equipment.dart';
import 'package:Maven/feature/exercise/model/exercise_group.dart';
import 'package:Maven/feature/exercise/model/exercise_set.dart';
import 'package:Maven/feature/exercise/model/exercise_type.dart';
import 'package:Maven/feature/template/dao/template_dao.dart';
import 'package:Maven/feature/template/dao/template_exercise_group_dao.dart';
import 'package:Maven/feature/template/dao/template_exercise_set_dao.dart';
import 'package:Maven/feature/workout/bloc/active_workout/workout_bloc.dart';
import 'package:Maven/feature/workout/dao/workout_dao.dart';
import 'package:Maven/feature/workout/dao/workout_exercise_group_dao.dart';
import 'package:Maven/feature/workout/dao/workout_exercise_set_dao.dart';
import 'package:Maven/feature/workout/model/workout_exercise_group.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExerciseDao extends Mock implements ExerciseDao {}
class MockTemplateDao extends Mock implements TemplateDao {}
class MockTemplateExerciseGroupDao extends Mock implements TemplateExerciseGroupDao {}
class MockTemplateExerciseSetDao extends Mock implements TemplateExerciseSetDao {}
class MockWorkoutDao extends Mock implements WorkoutDao {}
class MockWorkoutExerciseGroupDao extends Mock implements WorkoutExerciseGroupDao {}
class MockWorkoutExerciseSetDao extends Mock implements WorkoutExerciseSetDao {}

class FakeWorkoutExerciseGroup extends Fake implements WorkoutExerciseGroup {}
class FakeWorkoutExerciseSet extends Fake implements WorkoutExerciseSet {}

void main() {
  late ExerciseDao exerciseDao;
  late TemplateDao templateDao;
  late TemplateExerciseGroupDao templateExerciseGroupDao;
  late TemplateExerciseSetDao templateExerciseSetDao;
  late WorkoutDao workoutDao;
  late WorkoutExerciseGroupDao workoutExerciseGroupDao;
  late WorkoutExerciseSetDao workoutExerciseSetDao;

  group('WorkoutBloc', () {
    setUpAll(() {
      exerciseDao = MockExerciseDao();
      templateDao = MockTemplateDao();
      templateExerciseGroupDao = MockTemplateExerciseGroupDao();
      templateExerciseSetDao = MockTemplateExerciseSetDao();
      workoutDao = MockWorkoutDao();
      workoutExerciseGroupDao = MockWorkoutExerciseGroupDao();
      workoutExerciseSetDao = MockWorkoutExerciseSetDao();

      when(() => workoutDao.getActiveWorkoutAsStream(),).thenAnswer((_) => Stream.value(mockActiveWorkout));
      when(() => workoutDao.getPausedWorkoutsAsStream(),).thenAnswer((_) => Stream.value([]));
      when(() => workoutExerciseGroupDao.getWorkoutExerciseGroupsAsStream(),).thenAnswer((_) => Stream.value([]));
      when(() => workoutExerciseSetDao.getWorkoutExerciseSetsAsStream(),).thenAnswer((_) => Stream.value(mockWorkoutExerciseSets));
      when(() => exerciseDao.getExercise(any())).thenAnswer((invocation) async { return exercise;} );

      registerFallbackValue(FakeWorkoutExerciseSet());
      registerFallbackValue(FakeWorkoutExerciseGroup());
    });

    WorkoutBloc buildBloc() {
      return WorkoutBloc(
        exerciseDao: exerciseDao,
        templateDao: templateDao,
        templateExerciseGroupDao: templateExerciseGroupDao,
        templateExerciseSetDao: templateExerciseSetDao,
        workoutDao: workoutDao,
        workoutExerciseGroupDao: workoutExerciseGroupDao,
        workoutExerciseSetDao: workoutExerciseSetDao,
      );
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const WorkoutState()),
        );
      });
    });

    group('WorkoutInitialize', () {
      blocTest<WorkoutBloc, WorkoutState>(
        'starts listening to streams',
        build: buildBloc,
        act: (bloc) => bloc.add(WorkoutInitialize()),
        verify: (_) {
          verify(() => workoutDao.getActiveWorkoutAsStream()).called(1);
          verify(() => workoutDao.getPausedWorkoutsAsStream()).called(1);
          verify(() => workoutExerciseGroupDao.getWorkoutExerciseGroupsAsStream()).called(1);
          verify(() => workoutExerciseSetDao.getWorkoutExerciseSetsAsStream()).called(1);
        },
      );

      // TODO: MAKE SURE THIS ACTUALLY UPDATES THE STUFF...
      blocTest<WorkoutBloc, WorkoutState>(
        'emits state with updated workout and exercises',
        build: buildBloc,
        act: (bloc) => bloc.add(WorkoutInitialize()),
        expect: () => [
          const WorkoutState(
            status: WorkoutStatus.loading,
          ),
          const WorkoutState(
            status: WorkoutStatus.loaded,
          ),
          WorkoutState(
            status: WorkoutStatus.loaded,
            workout: mockActiveWorkout,
            pausedWorkouts: const [],
            exerciseGroups: const [],
          ),
        ],
      );
    });

    group('WorkoutExerciseSet', () {
      ExerciseSet exerciseSet = const ExerciseSet(
        exerciseSetId: 1,
        option1: 0,
        option2: 0,
        checked: 1,
        exerciseGroupId: 1,
      );

      WorkoutExerciseSet workoutExerciseSet = WorkoutExerciseSet(
        workoutExerciseSetId: 69420,
        option_1: 0,
        option_2: 0,
        checked: 1,
        workoutExerciseGroupId: 1,
        workoutId: mockActiveWorkout.workoutId!,
      );

      /// TODO: these literally physically computability or whatever should not be able to pass yet they do (the ids are diffrent)
      group('WorkoutExerciseSetAdd', () {
        blocTest<WorkoutBloc, WorkoutState>(
          'adds a workout exercise set',
          build: buildBloc,
          setUp: () {
            when(() => workoutExerciseSetDao.addWorkoutExerciseSet(any())).thenAnswer((_) async { return 1;});
          },
          seed: () => WorkoutState(workout: mockActiveWorkout),
          act: (bloc) => bloc.add(WorkoutExerciseSetAdd(exerciseSet: exerciseSet)),
          verify: (bloc) {
            verify(() => workoutExerciseSetDao.addWorkoutExerciseSet(workoutExerciseSet)).called(1);
          },
        );
      });

      group('WorkoutExerciseSetUpdate', () {
        blocTest<WorkoutBloc, WorkoutState>(
          'updates a workout exercise set',
          build: buildBloc,
          setUp: () {
            when(() => workoutExerciseSetDao.updateWorkoutExerciseSet(any())).thenAnswer((_) async {});
          },
          seed: () => WorkoutState(workout: mockActiveWorkout),
          act: (bloc) => bloc.add(WorkoutExerciseSetUpdate(exerciseSet: exerciseSet)),
          verify: (bloc) {
            verify(() => workoutExerciseSetDao.updateWorkoutExerciseSet(workoutExerciseSet)).called(1);
          },
        );
      });

      group('WorkoutExerciseSetDelete', () {
        blocTest<WorkoutBloc, WorkoutState>(
          'deletes a workout exercise set',
          build: buildBloc,
          setUp: () {
            when(() => workoutExerciseSetDao.deleteWorkoutExerciseSet(any())).thenAnswer((_) async {});
          },
          seed: () => WorkoutState(workout: mockActiveWorkout),
          act: (bloc) => bloc.add(WorkoutExerciseSetDelete(exerciseSet: exerciseSet)),
          verify: (bloc) {
            verify(() => workoutExerciseSetDao.deleteWorkoutExerciseSet(workoutExerciseSet)).called(1);
          },
        );
      });
    });

    group('WorkoutExerciseGroup', () {
      ExerciseGroup exerciseGroup = const ExerciseGroup(
        exerciseGroupId: 1,
        exerciseId: 99,
        barId: 60,
      );

      WorkoutExerciseGroup workoutExerciseGroup = WorkoutExerciseGroup(
        workoutExerciseGroupId: 1,
        exerciseId: 99,
        barId: 60,
        workoutId: mockActiveWorkout.workoutId!,
      );

      WorkoutExerciseGroup workoutExerciseGroupWithNullId = WorkoutExerciseGroup(
        workoutExerciseGroupId: null,
        exerciseId: 99,
        barId: 60,
        workoutId: mockActiveWorkout.workoutId!,
      );

      group('WorkoutExerciseGroupAdd', () {
        blocTest<WorkoutBloc, WorkoutState>(
          'adds a workout exercise group',
          build: buildBloc,
          setUp: () {
            when(() => workoutExerciseGroupDao.addWorkoutExerciseGroup(any())).thenAnswer((_) async {return 1;});
          },
          seed: () => WorkoutState(workout: mockActiveWorkout),
          act: (bloc) => bloc.add(WorkoutExerciseGroupAdd(exerciseGroup: exerciseGroup)),
          verify: (bloc) {
            verify(() => workoutExerciseGroupDao.addWorkoutExerciseGroup(workoutExerciseGroupWithNullId)).called(1);
          },
        );
      });

      group('WorkoutExerciseGroupUpdate', () {
        blocTest<WorkoutBloc, WorkoutState>(
          'updates a workout exercise group',
          build: buildBloc,
          setUp: () {
            when(() => workoutExerciseGroupDao.updateWorkoutExerciseGroup(any())).thenAnswer((_) async {});
          },
          seed: () => WorkoutState(workout: mockActiveWorkout),
          act: (bloc) => bloc.add(WorkoutExerciseGroupUpdate(exerciseGroup: exerciseGroup)),
          verify: (bloc) {
            verify(() => workoutExerciseGroupDao.updateWorkoutExerciseGroup(workoutExerciseGroup)).called(1);
          },
        );
      });
    });

  });
}

Workout mockActiveWorkout = Workout(
  workoutId: 1,
  name: 'nice!',
  isPaused: 0,
  timestamp: DateTime.now(),
);

List<Workout> mockPausedWorkouts = [
  Workout(
    workoutId: 2,
    name: 'second!',
    isPaused: 1,
    timestamp: DateTime.now(),
  ),
  Workout(
    workoutId: 3,
    name: 'third!',
    isPaused: 1,
    timestamp: DateTime.now(),
  ),
];



List<ExerciseGroup> mockExerciseGroups = [
  const ExerciseGroup(exerciseGroupId: 1, exerciseId: 99, barId: 99,),
  const ExerciseGroup(exerciseGroupId: 2, exerciseId: 99, barId: 99,),
];

List<WorkoutExerciseSet> mockWorkoutExerciseSets = [
  WorkoutExerciseSet(
    workoutExerciseSetId: 1,
    option_1: 0,
    checked: 0,
    workoutExerciseGroupId: 99,
    workoutId: 99,
  ),
  WorkoutExerciseSet(
    workoutExerciseSetId: 2,
    option_1: 0,
    checked: 0,
    workoutExerciseGroupId: 99,
    workoutId: 99,
  )
];

Exercise exercise = const Exercise(
  exerciseId: 85,
  name: 'jumping hack',
  muscle: 'whoops',
  picture: 'nice',
  exerciseType: ExerciseType(
      exerciseTypeId: 1,
      exerciseTypeOption1: ExerciseTypeOption.addWeight,
      name: 'hey'
  ),
  exerciseEquipment: ExerciseEquipment.machine,
);