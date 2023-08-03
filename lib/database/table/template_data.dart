
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'template_data',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['routine_id'],
      parentColumns: ['id'],
      entity: Routine,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TemplateData extends Equatable {
  const TemplateData({
    this.id,
    required this.sort,
    required this.routineId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'sort')
  final int sort;

  @ColumnInfo(name: 'routine_id')
  final int routineId;

  TemplateData copyWith({
    int? id,
    int? sort,
    int? routineId,
  }) {
    return TemplateData(
      id: id ?? this.id,
      sort: sort ?? this.sort,
      routineId: routineId ?? this.routineId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    sort,
    routineId,
  ];
}