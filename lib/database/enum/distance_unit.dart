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

  String get abbreviated {
    switch (this) {
      case DistanceUnit.meter:
        return 'm';
      case DistanceUnit.kilometer:
        return 'km';
      case DistanceUnit.mile:
        return 'mi';
      case DistanceUnit.feet:
        return 'ft';
      case DistanceUnit.centimeter:
        return 'cm';
      case DistanceUnit.inch:
        return 'in';
    }
  }
}