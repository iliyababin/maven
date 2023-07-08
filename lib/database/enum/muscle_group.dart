
import 'package:maven/common/common.dart';

enum MuscleGroup {
  arms,
  back,
  chest,
  core,
  legs,
  shoulders,
  fullBody;

  String get name {
    return toString().split('.').last.capitalize;
  }
}

