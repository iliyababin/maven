import 'package:maven/common/common.dart';

enum WeightUnit {
  pound,
  kilogram;

  String get name {
    return toString().split('.').last.capitalize;
  }

  String get abbreviated {
    switch (this) {
      case WeightUnit.pound:
        return 'lb';
      case WeightUnit.kilogram:
        return 'kg';
    }
  }
}