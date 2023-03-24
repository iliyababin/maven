import 'package:floor/floor.dart';

import '../../common/model/timed.dart';

class TimedConverter extends TypeConverter<Timed, int> {
  @override
  Timed decode(int databaseValue) {
    return Timed.fromSeconds(databaseValue);
  }

  @override
  int encode(Timed value) {
    return value.toSeconds();
  }
}