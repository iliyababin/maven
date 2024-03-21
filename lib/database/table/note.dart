import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../database.dart';

part 'note.g.dart';

@Entity(
  tableName: 'note',
  foreignKeys: [
    ForeignKey(
      childColumns: ['exercise_group_id'],
      parentColumns: ['id'],
      entity: BaseExerciseGroup,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
@JsonSerializable()
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

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}