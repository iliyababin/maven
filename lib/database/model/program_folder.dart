import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'program_folder',
  primaryKeys: [
    'id',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: [
        'program_id',
      ],
      parentColumns: [
        'id',
      ],
      entity: Program,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class ProgramFolder extends Equatable {
  const ProgramFolder({
    this.id,
    required this.order,
    required this.programId,
    this.templates = const [],
  });

  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'order')
  final int order;

  @ColumnInfo(name: 'program_id')
  final int programId;

  @ignore
  final List<ProgramTemplate> templates;

  ProgramFolder copyWith({
    int? id,
    int? order,
    int? programId,
    List<ProgramTemplate>? templates,
  }) {
    return ProgramFolder(
      id: id ?? this.id,
      order: order ?? this.order,
      programId: programId ?? this.programId,
      templates: templates ?? this.templates,
    );
  }

  @override
  List<Object?> get props => [
    id,
    order,
    programId,
    templates,
  ];
}