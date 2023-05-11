import 'package:floor/floor.dart';

import '../../feature/exercise/model/set_type.dart';

class SetTypeConverter extends TypeConverter<SetType, String> {
  @override
  SetType decode(String databaseValue) {
    return SetType.fromName(databaseValue);
  }

  @override
  String encode(SetType value) {
    return value.name;
  }
}