import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:maven/feature/exercise/model/set_type.dart';

abstract class RoutineSet extends Equatable {
  const RoutineSet({
    required this.id,
    required this.type,
    required this.checked,
    required this.exerciseGroupId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'set_type')
  final SetType type;

  @ColumnInfo(name: 'checked')
  final bool checked;

  @ColumnInfo(name: 'exercise_group_id')
  final int exerciseGroupId;

  @override
  List<Object?> get props => [
    id,
    type,
    checked,
  ];

  RoutineSet copyWith();
}