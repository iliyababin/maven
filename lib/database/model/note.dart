import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class Note extends Equatable {
  const Note({
    this.id,
    required this.data,
    required this.exerciseGroupId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'data')
  final String data;

  @ColumnInfo(name: 'exercise_group_id')
  final int exerciseGroupId;

  Note copyWith({
    int? id,
    String? data,
    int? exerciseGroupId,
  }) {
    return Note(
      id: id ?? this.id,
      data: data ?? this.data,
      exerciseGroupId: exerciseGroupId ?? this.exerciseGroupId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    data,
    exerciseGroupId,
  ];
}