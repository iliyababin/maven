import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: '{Table Name}[-s]',
  primaryKeys: [
    'id',
  ],
)
class {Table Name}[-C] extends Equatable {
  const {Table Name}[-C]({
    this.id,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  {Table Name}[-C] copyWith({
    int? id,
  }) {
    return {Table Name}[-C](
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
