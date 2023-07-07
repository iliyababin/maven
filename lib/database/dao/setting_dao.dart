
import 'package:floor/floor.dart';

import '../model/setting.dart';

@dao
abstract class SettingDao {
  @Query('SELECT * FROM setting')
  Future<BaseSetting?> getSetting();

  @update
  Future<int> updateSetting(BaseSetting setting);
}