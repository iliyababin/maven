
import 'package:floor/floor.dart';

import '../model/setting.dart';

@dao
abstract class SettingDao {
  @insert
  Future<int> add(BaseSetting setting);

  @Query('SELECT * FROM setting WHERE id = 1')
  Future<BaseSetting?> get();

  @update
  Future<int> modify(BaseSetting setting);

  @delete
  Future<int> remove(BaseSetting setting);
}