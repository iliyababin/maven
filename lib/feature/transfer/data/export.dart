import 'package:floor/floor.dart';

@Entity(
  tableName: 'export',
  primaryKeys: [
    'id',
  ],
)
class Export {
  const Export({
    this.id,
    required this.date,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'date')
  final DateTime date;
}