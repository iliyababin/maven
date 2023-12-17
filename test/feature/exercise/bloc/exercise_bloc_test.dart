/*
import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maven/common/common.dart';
import 'package:maven/database/database.dart';
import 'package:maven/feature/exercise/exercise.dart';
import 'package:mocktail/mocktail.dart';

class MockExerciseDao extends Mock implements ExerciseDao {}

class MockExerciseFieldDao extends Mock implements ExerciseFieldDao {}

void main() {
  group('ExerciseBloc', () {
    late ExerciseDao exerciseDao;
    late ExerciseFieldDao exerciseFieldDao;
    late Exercise exercise;

    setUp(() {
      exerciseDao = MockExerciseDao();
      exerciseFieldDao = MockExerciseFieldDao();
      exercise = const Exercise(
        name: 'Bench Press',
        equipment: Equipment.assisted,
        muscle: Muscle.brachialis,
        muscleGroup: MuscleGroup.arms,
        videoPath: '',
        timer: Timed.zero(),
        fields: [
          ExerciseField(
            exerciseId: 1,
            type: ExerciseFieldType.assisted,
          ),
        ],
      );
    });

    ExerciseBloc buildBloc() {
      return ExerciseBloc(
        exerciseDao: exerciseDao,
        exerciseFieldDao: exerciseFieldDao,
      );
    }

    setUp(() {
      when(() => exerciseDao.add(exercise)).thenAnswer((_) async => 1);
      when(() => exerciseDao.getExercises()).thenAnswer(
              (_) async => [exercise.copyWith(id: 1, isCustom: true)]);
      when(() => exerciseFieldDao.add(exercise.fields.first))
          .thenAnswer((_) async => 1);
      when(() => exerciseFieldDao.getByExerciseId(1))
          .thenAnswer((_) async => [exercise.fields.first.copyWith(id: 1)]);
    });

    blocTest(
      'initial state is correct',
      build: buildBloc,
      setUp: () {
        when(() => exerciseDao.getExercises()).thenAnswer((_) async => []);
      },
      act: (bloc) {
        bloc.add(const ExerciseInitialize());
      },
      expect: () => [
        const ExerciseState(
          status: ExerciseStatus.loaded,
          exercises: [],
        ),
      ],
    );

    blocTest(
      'add exercise and update state',
      build: buildBloc,
      setUp: () {

      },
      act: (bloc) async => bloc.add(ExerciseAdd(
        exercise: exercise,
      )),
      expect: () => [
        const ExerciseState(
          status: ExerciseStatus.loading,
          exercises: [],
        ),
        ExerciseState(
          status: ExerciseStatus.loaded,
          exercises: [
            exercise.copyWith(
              isCustom: true,
              id: 1,
            )
          ],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.exercises.first.fields.first,
            exercise.fields.first.copyWith(id: 1));
      },
    );

    ExerciseBloc buildBlocWithExercise() {
      final bloc =  ExerciseBloc(
        exerciseDao: exerciseDao,
        exerciseFieldDao: exerciseFieldDao,
      );
      bloc.state.copyWith(exercises: [exercise.copyWith(id: 1, isCustom: true)]);
    }

    blocTest(
      'update exercise',
      build: buildBlocWithExercise,
      setUp: () {
        when(() => exerciseDao.getExercises())
            .thenAnswer((_) async => [exercise.copyWith(id: 1, isCustom: true, name: 'nice')]);
        when(() => exerciseDao.updateExercise(exercise.copyWith(id: 1, name: 'nice')))
            .thenAnswer((_) async => 1);
      },
      act: (bloc) async {
        bloc.add(ExerciseUpdate(exercise: exercise.copyWith(id: 1, name: 'nice')));
      },
      expect: () => [
        const ExerciseState(
          status: ExerciseStatus.loading,
          exercises: [],
        ),
        ExerciseState(
          status: ExerciseStatus.loaded,
          exercises: [
            exercise.copyWith(id: 1, isCustom: true, name: 'nice'),
          ],
        ),
      ],
    );
  });
}
*/
