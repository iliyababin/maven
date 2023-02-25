import 'dart:ui';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@Entity(tableName: 'plate')
class Plate {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'plate_id')
  final int? plateId;

  @ColumnInfo(name: 'weight')
  final double weight;

  @ColumnInfo(name: 'amount')
  final int amount;

  @ColumnInfo(name: 'color')
  final Color color;

  @ColumnInfo(name: 'height')
  final double height;

  @ColumnInfo(name: 'is_customized')
  final bool isCustomized;

  const Plate({
    this.plateId,
    required this.weight,
    required this.amount,
    required this.color,
    required this.height,
    required this.isCustomized,
  });
}

List<Plate> getDefaultPlates() => [
  const Plate(
    plateId: 1,
    weight: 45,
    amount: 1,
    color: Colors.blue,
    height: 1,
    isCustomized: false,
  ),
  const Plate(
    plateId: 2,
    weight: 35,
    amount: 99,
    color: Color(0xFFFF803B),
    height: 0.9,
    isCustomized: false,
  ),
  const Plate(
    plateId: 3,
    weight: 25,
    amount: 99,
    color: Colors.green,
    height: 0.8,
    isCustomized: false,
  ),
  const Plate(
    plateId: 4,
    weight: 10,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.7,
    isCustomized: false,
  ),
  const Plate(
    plateId: 5,
    weight: 5,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.6,
    isCustomized: false,
  ),
  const Plate(
    plateId: 6,
    weight: 2.5,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.5,
    isCustomized: false,
  ),
];