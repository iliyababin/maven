// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ImportCWProxy {
  Import id(int? id);

  Import timestamp(DateTime timestamp);

  Import source(TransferSource source);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Import(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Import(...).copyWith(id: 12, name: "My name")
  /// ````
  Import call({
    int? id,
    DateTime? timestamp,
    TransferSource? source,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfImport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfImport.copyWith.fieldName(...)`
class _$ImportCWProxyImpl implements _$ImportCWProxy {
  const _$ImportCWProxyImpl(this._value);

  final Import _value;

  @override
  Import id(int? id) => this(id: id);

  @override
  Import timestamp(DateTime timestamp) => this(timestamp: timestamp);

  @override
  Import source(TransferSource source) => this(source: source);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Import(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Import(...).copyWith(id: 12, name: "My name")
  /// ````
  Import call({
    Object? id = const $CopyWithPlaceholder(),
    Object? timestamp = const $CopyWithPlaceholder(),
    Object? source = const $CopyWithPlaceholder(),
  }) {
    return Import(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      timestamp: timestamp == const $CopyWithPlaceholder() || timestamp == null
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as DateTime,
      source: source == const $CopyWithPlaceholder() || source == null
          ? _value.source
          // ignore: cast_nullable_to_non_nullable
          : source as TransferSource,
    );
  }
}

extension $ImportCopyWith on Import {
  /// Returns a callable class that can be used as follows: `instanceOfImport.copyWith(...)` or like so:`instanceOfImport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ImportCWProxy get copyWith => _$ImportCWProxyImpl(this);
}
