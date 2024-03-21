// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_group_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExerciseGroupDtoCWProxy {
  ExerciseGroupDto id(int? id);

  ExerciseGroupDto timer(Timed timer);

  ExerciseGroupDto weightUnit(WeightUnit? weightUnit);

  ExerciseGroupDto distanceUnit(DistanceUnit? distanceUnit);

  ExerciseGroupDto exerciseId(int exerciseId);

  ExerciseGroupDto barId(int? barId);

  ExerciseGroupDto routineId(int? routineId);

  ExerciseGroupDto sets(List<ExerciseSetDto> sets);

  ExerciseGroupDto notes(List<Note> notes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExerciseGroupDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExerciseGroupDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExerciseGroupDto call({
    int? id,
    Timed? timer,
    WeightUnit? weightUnit,
    DistanceUnit? distanceUnit,
    int? exerciseId,
    int? barId,
    int? routineId,
    List<ExerciseSetDto>? sets,
    List<Note>? notes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExerciseGroupDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExerciseGroupDto.copyWith.fieldName(...)`
class _$ExerciseGroupDtoCWProxyImpl implements _$ExerciseGroupDtoCWProxy {
  const _$ExerciseGroupDtoCWProxyImpl(this._value);

  final ExerciseGroupDto _value;

  @override
  ExerciseGroupDto id(int? id) => this(id: id);

  @override
  ExerciseGroupDto timer(Timed timer) => this(timer: timer);

  @override
  ExerciseGroupDto weightUnit(WeightUnit? weightUnit) =>
      this(weightUnit: weightUnit);

  @override
  ExerciseGroupDto distanceUnit(DistanceUnit? distanceUnit) =>
      this(distanceUnit: distanceUnit);

  @override
  ExerciseGroupDto exerciseId(int exerciseId) => this(exerciseId: exerciseId);

  @override
  ExerciseGroupDto barId(int? barId) => this(barId: barId);

  @override
  ExerciseGroupDto routineId(int? routineId) => this(routineId: routineId);

  @override
  ExerciseGroupDto sets(List<ExerciseSetDto> sets) => this(sets: sets);

  @override
  ExerciseGroupDto notes(List<Note> notes) => this(notes: notes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExerciseGroupDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExerciseGroupDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExerciseGroupDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? timer = const $CopyWithPlaceholder(),
    Object? weightUnit = const $CopyWithPlaceholder(),
    Object? distanceUnit = const $CopyWithPlaceholder(),
    Object? exerciseId = const $CopyWithPlaceholder(),
    Object? barId = const $CopyWithPlaceholder(),
    Object? routineId = const $CopyWithPlaceholder(),
    Object? sets = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
  }) {
    return ExerciseGroupDto(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      timer: timer == const $CopyWithPlaceholder() || timer == null
          ? _value.timer
          // ignore: cast_nullable_to_non_nullable
          : timer as Timed,
      weightUnit: weightUnit == const $CopyWithPlaceholder()
          ? _value.weightUnit
          // ignore: cast_nullable_to_non_nullable
          : weightUnit as WeightUnit?,
      distanceUnit: distanceUnit == const $CopyWithPlaceholder()
          ? _value.distanceUnit
          // ignore: cast_nullable_to_non_nullable
          : distanceUnit as DistanceUnit?,
      exerciseId:
          exerciseId == const $CopyWithPlaceholder() || exerciseId == null
              ? _value.exerciseId
              // ignore: cast_nullable_to_non_nullable
              : exerciseId as int,
      barId: barId == const $CopyWithPlaceholder()
          ? _value.barId
          // ignore: cast_nullable_to_non_nullable
          : barId as int?,
      routineId: routineId == const $CopyWithPlaceholder()
          ? _value.routineId
          // ignore: cast_nullable_to_non_nullable
          : routineId as int?,
      sets: sets == const $CopyWithPlaceholder() || sets == null
          ? _value.sets
          // ignore: cast_nullable_to_non_nullable
          : sets as List<ExerciseSetDto>,
      notes: notes == const $CopyWithPlaceholder() || notes == null
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as List<Note>,
    );
  }
}

extension $ExerciseGroupDtoCopyWith on ExerciseGroupDto {
  /// Returns a callable class that can be used as follows: `instanceOfExerciseGroupDto.copyWith(...)` or like so:`instanceOfExerciseGroupDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExerciseGroupDtoCWProxy get copyWith => _$ExerciseGroupDtoCWProxyImpl(this);
}
