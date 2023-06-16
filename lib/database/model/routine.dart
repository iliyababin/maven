import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

abstract class Routine extends Equatable {
  const Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.timestamp,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'description')
  final String description;

  @ColumnInfo(name: 'timestamp')
  final DateTime timestamp;

  Routine copyWith();
}
