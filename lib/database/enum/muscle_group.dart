
import 'package:maven/common/common.dart';

enum MuscleGroup {
  arms,
  back,
  chest,
  core,
  legs,
  shoulders,
  fullBody,
  none;

  String get name {
    return toString().split('.').last.capitalize;
  }
}

