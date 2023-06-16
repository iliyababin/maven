import 'package:flutter/material.dart';

import '../database.dart';

List<Plate> getDefaultPlates() => [
  const Plate(
    id: 1,
    weight: 45,
    amount: 1,
    color: Colors.blue,
    height: 1,
  ),
  const Plate(
    id: 2,
    weight: 35,
    amount: 99,
    color: Color(0xFFFF803B),
    height: 0.9,
  ),
  const Plate(
    id: 3,
    weight: 25,
    amount: 99,
    color: Colors.green,
    height: 0.8,
  ),
  const Plate(
    id: 4,
    weight: 10,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.7,
  ),
  const Plate(
    id: 5,
    weight: 5,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.6,
  ),
  const Plate(
    id: 6,
    weight: 2.5,
    amount: 99,
    color: Color(0xFF373C41),
    height: 0.5,
  ),
];