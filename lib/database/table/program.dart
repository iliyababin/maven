import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../database.dart';

@Entity(
  tableName: 'program',
  primaryKeys: [
    'id',
  ],
)
class Program extends Equatable {
  const Program({
    this.id,
    required this.name,
    required this.timestamp,
    required this.weeks,
    this.folders = const [],
  });

  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'timestamp')
  final DateTime timestamp;

  @ColumnInfo(name: 'weeks')
  final int weeks;

  @ignore
  final List<ProgramFolder> folders;

  Program copyWith({
    int? id,
    String? name,
    DateTime? timestamp,
    int? weeks,
    List<ProgramFolder>? folders,
  }) {
    return Program(
      id: id ?? this.id,
      name: name ?? this.name,
      timestamp: timestamp ?? this.timestamp,
      weeks: weeks ?? this.weeks,
      folders: folders ?? this.folders,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    timestamp,
    weeks,
    folders,
  ];
}
