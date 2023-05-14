
import 'package:floor/floor.dart';

class DurationConverter extends TypeConverter<Duration, int> {
  @override
  Duration decode(int databaseValue) {
    return Duration(seconds: databaseValue);
  }

  @override
  int encode(Duration value) {
    return value.inSeconds;
  }
}