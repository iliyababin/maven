import 'package:maven/common/common.dart';

enum Unit {
  imperial,
  metric;

  String get name {
    return toString().split('.').last.capitalize;
  }
}