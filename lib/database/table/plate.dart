import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@Entity(
  tableName: 'plate',
  primaryKeys: [
    'id',
  ],
)
class Plate extends Equatable {
  const Plate({
    this.id,
    required this.weight,
    required this.amount,
    required this.color,
    required this.height,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'weight')
  final double weight;

  @ColumnInfo(name: 'amount')
  final int amount;

  @ColumnInfo(name: 'color')
  final Color color;

  @ColumnInfo(name: 'height')
  final double height;

  @override
  List<Object?> get props => [
        id,
        weight,
        amount,
        color,
        height,
      ];
}
