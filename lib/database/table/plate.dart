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

  const Plate.empty()
      : this(
          weight: 0,
          amount: 0,
          color: Colors.red,
          height: 1,
        );

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

  Plate copyWith({
    int? id,
    double? weight,
    int? amount,
    Color? color,
    double? height,
  }) {
    return Plate(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      amount: amount ?? this.amount,
      color: color ?? this.color,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => [
        id,
        weight,
        amount,
        color,
        height,
      ];

  @override
  String toString() {
    return 'Plate { id: $id, weight: $weight, amount: $amount, color: $color, height: $height }';
  }
}
