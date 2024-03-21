// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Routine _$RoutineFromJson(Map<String, dynamic> json) => Routine(
      id: json['id'] as int?,
      name: json['name'] as String,
      note: json['note'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: $enumDecode(_$RoutineTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$RoutineToJson(Routine instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$RoutineTypeEnumMap[instance.type]!,
    };

const _$RoutineTypeEnumMap = {
  RoutineType.template: 'template',
  RoutineType.workout: 'workout',
  RoutineType.session: 'session',
};
