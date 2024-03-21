// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set_data_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExerciseSetDataDtoCWProxy {
  ExerciseSetDataDto id(int? id);

  ExerciseSetDataDto value(String value);

  ExerciseSetDataDto fieldType(ExerciseFieldType fieldType);

  ExerciseSetDataDto exerciseSetId(int exerciseSetId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExerciseSetDataDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExerciseSetDataDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExerciseSetDataDto call({
    int? id,
    String? value,
    ExerciseFieldType? fieldType,
    int? exerciseSetId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExerciseSetDataDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExerciseSetDataDto.copyWith.fieldName(...)`
class _$ExerciseSetDataDtoCWProxyImpl implements _$ExerciseSetDataDtoCWProxy {
  const _$ExerciseSetDataDtoCWProxyImpl(this._value);

  final ExerciseSetDataDto _value;

  @override
  ExerciseSetDataDto id(int? id) => this(id: id);

  @override
  ExerciseSetDataDto value(String value) => this(value: value);

  @override
  ExerciseSetDataDto fieldType(ExerciseFieldType fieldType) =>
      this(fieldType: fieldType);

  @override
  ExerciseSetDataDto exerciseSetId(int exerciseSetId) =>
      this(exerciseSetId: exerciseSetId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExerciseSetDataDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExerciseSetDataDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExerciseSetDataDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? fieldType = const $CopyWithPlaceholder(),
    Object? exerciseSetId = const $CopyWithPlaceholder(),
  }) {
    return ExerciseSetDataDto(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      value: value == const $CopyWithPlaceholder() || value == null
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
      fieldType: fieldType == const $CopyWithPlaceholder() || fieldType == null
          ? _value.fieldType
          // ignore: cast_nullable_to_non_nullable
          : fieldType as ExerciseFieldType,
      exerciseSetId:
          exerciseSetId == const $CopyWithPlaceholder() || exerciseSetId == null
              ? _value.exerciseSetId
              // ignore: cast_nullable_to_non_nullable
              : exerciseSetId as int,
    );
  }
}

extension $ExerciseSetDataDtoCopyWith on ExerciseSetDataDto {
  /// Returns a callable class that can be used as follows: `instanceOfExerciseSetDataDto.copyWith(...)` or like so:`instanceOfExerciseSetDataDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExerciseSetDataDtoCWProxy get copyWith =>
      _$ExerciseSetDataDtoCWProxyImpl(this);
}
