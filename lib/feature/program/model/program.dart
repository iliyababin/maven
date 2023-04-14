import 'package:floor/floor.dart';

@Entity(
  tableName: 'program',
  primaryKeys: [
    'program_id',
  ],
)
class Program {
  const Program({
    required this.programId,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'program_id')
  final int programId;
}