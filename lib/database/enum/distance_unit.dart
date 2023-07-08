import 'package:maven/common/common.dart';

enum DistanceUnit {
  meter,
  kilometer,
  mile,
  feet,
  centimeter,
  inch;

  String get name {
    return toString().split('.').last.capitalize;
  }
}