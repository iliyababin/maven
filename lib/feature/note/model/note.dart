
import '../../../database/database.dart';

class Note extends BaseNote {
  const Note({
    super.id,
    required super.data,
    required super.exerciseGroupId,
  });

  @override
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