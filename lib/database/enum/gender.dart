import 'package:maven/common/common.dart';

// yes only 2
enum Gender {
  male,
  female;

  String get name {
    return toString().split('.').last.capitalize;
  }
}