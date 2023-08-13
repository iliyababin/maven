import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'import',
  primaryKeys: [
    'id',
  ],
)
class Import extends Equatable {
  const Import({
    this.id,
    required this.timestamp,
    required this.source,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'timestamp')
  final DateTime timestamp;

  @ColumnInfo(name: 'transfer_source')
  final TransferSource source;

  Import copyWith({
    int? id,
    DateTime? timestamp,
    TransferSource? source,
  }) {
    return Import(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [
        id,
        timestamp,
        source,
      ];
}
