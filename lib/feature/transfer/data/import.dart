import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../transfer.dart';

part 'import.g.dart';

@Entity(
  tableName: 'import',
  primaryKeys: [
    'id',
  ],
)
@CopyWith()
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

  @override
  List<Object?> get props => [
        id,
        timestamp,
        source,
      ];
}
