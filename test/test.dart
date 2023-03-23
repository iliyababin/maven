import 'package:Maven/feature/exercise/dao/exercise_dao.dart';
import 'package:Maven/feature/exercise/dto/exercise_group.dart';
import 'package:Maven/feature/exercise/model/exercise.dart';
import 'package:Maven/feature/exercise/model/exercise_equipment.dart';
import 'package:Maven/feature/exercise/model/exercise_type.dart';
import 'package:Maven/feature/template/dao/template_dao.dart';
import 'package:Maven/feature/template/dao/template_exercise_group_dao.dart';
import 'package:Maven/feature/template/dao/template_exercise_set_dao.dart';
import 'package:Maven/feature/template/model/template.dart';
import 'package:Maven/feature/workout/bloc/active_workout/workout_bloc.dart';
import 'package:Maven/feature/workout/dao/workout_dao.dart';
import 'package:Maven/feature/workout/dao/workout_exercise_group_dao.dart';
import 'package:Maven/feature/workout/dao/workout_exercise_set_dao.dart';
import 'package:Maven/feature/workout/model/workout.dart';
import 'package:Maven/feature/workout/model/workout_exercise_group.dart';
import 'package:Maven/feature/workout/model/workout_exercise_set.dart';
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

void main() {
  late ExerciseDao exerciseDao;
  late TemplateDao templateDao;
  late TemplateExerciseGroupDao templateExerciseGroupDao;
  late TemplateExerciseSetDao templateExerciseSetDao;
  late WorkoutDao workoutDao;
  late WorkoutExerciseGroupDao workoutExerciseGroupDao;
  late WorkoutExerciseSetDao workoutExerciseSetDao;

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

  List<WorkoutExerciseGroup> mockWorkoutExerciseGroups = [
    const WorkoutExerciseGroup(
      workoutExerciseGroupId: 1,
      barId: 99,
      exerciseId: 99,
      workoutId: 99
    ),
    const WorkoutExerciseGroup(
        workoutExerciseGroupId: 2,
        barId: 99,
        exerciseId: 99,
        workoutId: 99
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

  Exercise mockExercise = const Exercise(
    exerciseId: 99,
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

  setUp(() {
    exerciseDao = MockExerciseDao();
    templateDao = MockTemplateDao();
    templateExerciseGroupDao = MockTemplateExerciseGroupDao();
    templateExerciseSetDao = MockTemplateExerciseSetDao();
    workoutDao = MockWorkoutDao();
    workoutExerciseGroupDao = MockWorkoutExerciseGroupDao();
    workoutExerciseSetDao = MockWorkoutExerciseSetDao();

    when(() => workoutDao.getActiveWorkoutAsStream(),).thenAnswer((_) => Stream.value(mockActiveWorkout));
    when(() => workoutDao.getPausedWorkoutsAsStream(),).thenAnswer((_) => Stream.value([]));
    when(() => workoutExerciseGroupDao.getWorkoutExerciseGroupsAsStream(),).thenAnswer((_) => Stream.value(mockWorkoutExerciseGroups));
    when(() => workoutExerciseSetDao.getWorkoutExerciseSetsAsStream(),).thenAnswer((_) => Stream.value(mockWorkoutExerciseSets));
    when(() => exerciseDao.getExercise(any())).thenAnswer((invocation) async { return mockExercise;} );
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

  group('WorkoutExerciseSetAdd', () {
    blocTest<WorkoutBloc, WorkoutState>(
      'starts listening to streams',
      build: buildBloc,
      act: (bloc) => bloc.add(WorkoutInitialize()),
      verify: (_) {
        verify(() => workoutDao.getActiveWorkoutAsStream()).called(1);
        verify(() => workoutDao.getPausedWorkoutsAsStream()).called(1);
      },
    );

    blocTest<WorkoutBloc, WorkoutState>(
      'emits state with updated status and todos '
          'when repository getTodos stream emits new todos',
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

  group('WorkoutStartTemplate', () {
    const mockTemplate = Template(
      name: 'hey',
    );

    blocTest<WorkoutBloc, WorkoutState>(
      '',
      build: buildBloc,
      setUp: () {
        when(() => workoutDao.addWorkout(any()),).thenReturn(1 as Future<int>);
      },
      act: (bloc) => bloc.add(const WorkoutStartTemplate(
        template: mockTemplate,
      )),
      verify: (bloc) {
        verify(() => workoutDao.addWorkout(any()),).called(1);
      },
    );
  });
}