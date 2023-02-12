import 'dart:ui';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@Entity(tableName: 'plate')
class Plate {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'plate_id')
  final int plateId;

  @ColumnInfo(name: 'weight_lb')
  final double weightLb;

  @ColumnInfo(name: 'weight_kg')
  final double weightKg;

  @ColumnInfo(name: 'amount')
  final int amount;

  @ColumnInfo(name: 'color')
  final Color color;

  @ColumnInfo(name: 'height')
  final double height;

  const Plate({
    required this.plateId,
    required this.weightLb,
    required this.weightKg,
    required this.amount,
    required this.color,
    required this.height,
  });
}

List<Plate> getDefaultPlates() => [
  const Plate(
    plateId: 1,
    weightLb: 45,
    weightKg: 20,
    amount: 99,
    color: Colors.blue,
    height: 1,
  ),
  const Plate(
    plateId: 2,
    weightLb: 35,
    weightKg: 15,
    amount: 99,
    color: Color(0xFFFF803B),
    height: 0.9,
  ),
  const Plate(
    plateId: 3,
    weightLb: 25,
    weightKg: 10,
    amount: 99,
    color: Colors.green,
    height: 0.8,
  ),
  const Plate(
    plateId: 4,
    weightLb: 10,
    weightKg: 5,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.7,
  ),
  const Plate(
    plateId: 5,
    weightLb: 5,
    weightKg: 2.25,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.6,
  ),
  const Plate(
    plateId: 6,
    weightLb: 2.5,
    weightKg: 1.1,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.5,
  ),
];