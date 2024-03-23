import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine.g.dart';

enum RoutineType {
  template,
  workout,
  session,
}

@Entity(
  tableName: 'routine',
  primaryKeys: [
    'id',
  ],
)
@JsonSerializable()
@CopyWith()
class Routine extends Equatable {
  const Routine({
    this.id,
    required this.name,
    required this.note,
    required this.timestamp,
    required this.type,
  });

  Routine.empty()
      : id = 1,
        name = '',
        note = '',
        timestamp = DateTime.now(),
        type = RoutineType.template;

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String note;

  @ColumnInfo(name: 'timestamp')
  final DateTime timestamp;

  @ColumnInfo(name: 'type')
  final RoutineType type;



  @override
  List<Object?> get props => [
        id,
        name,
        note,
        timestamp,
        type,
      ];

  factory Routine.fromJson(Map<String, dynamic> json) => _$RoutineFromJson(json);
  Map<String, dynamic> toJson() => _$RoutineToJson(this);
}
