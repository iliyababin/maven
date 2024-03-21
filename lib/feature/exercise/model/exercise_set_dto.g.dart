// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExerciseSetDtoCWProxy {
  ExerciseSetDto id(int? id);

  ExerciseSetDto type(ExerciseSetType type);

  ExerciseSetDto checked(bool checked);

  ExerciseSetDto exerciseGroupId(int exerciseGroupId);

  ExerciseSetDto data(List<ExerciseSetDataDto> data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExerciseSetDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExerciseSetDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExerciseSetDto call({
    int? id,
    ExerciseSetType? type,
    bool? checked,
    int? exerciseGroupId,
    List<ExerciseSetDataDto>? data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExerciseSetDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExerciseSetDto.copyWith.fieldName(...)`
class _$ExerciseSetDtoCWProxyImpl implements _$ExerciseSetDtoCWProxy {
  const _$ExerciseSetDtoCWProxyImpl(this._value);

  final ExerciseSetDto _value;

  @override
  ExerciseSetDto id(int? id) => this(id: id);

  @override
  ExerciseSetDto type(ExerciseSetType type) => this(type: type);

  @override
  ExerciseSetDto checked(bool checked) => this(checked: checked);

  @override
  ExerciseSetDto exerciseGroupId(int exerciseGroupId) =>
      this(exerciseGroupId: exerciseGroupId);

  @override
  ExerciseSetDto data(List<ExerciseSetDataDto> data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExerciseSetDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExerciseSetDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExerciseSetDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? checked = const $CopyWithPlaceholder(),
    Object? exerciseGroupId = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return ExerciseSetDto(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ExerciseSetType,
      checked: checked == const $CopyWithPlaceholder() || checked == null
          ? _value.checked
          // ignore: cast_nullable_to_non_nullable
          : checked as bool,
      exerciseGroupId: exerciseGroupId == const $CopyWithPlaceholder() ||
              exerciseGroupId == null
          ? _value.exerciseGroupId
          // ignore: cast_nullable_to_non_nullable
          : exerciseGroupId as int,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<ExerciseSetDataDto>,
    );
  }
}

extension $ExerciseSetDtoCopyWith on ExerciseSetDto {
  /// Returns a callable class that can be used as follows: `instanceOfExerciseSetDto.copyWith(...)` or like so:`instanceOfExerciseSetDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExerciseSetDtoCWProxy get copyWith => _$ExerciseSetDtoCWProxyImpl(this);
}
