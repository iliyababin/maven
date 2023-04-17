import 'package:floor/floor.dart';

@Entity(
  tableName: 'program',
  primaryKeys: [
    'program_id',
  ],
)
class Program {
  const Program({
    this.programId,
    required this.name,
    required this.weeks,
    required this.createdAt,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'program_id')
  final int? programId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'weeks')
  final int weeks;

  @ColumnInfo(name: 'created_at')
  final DateTime createdAt;
}