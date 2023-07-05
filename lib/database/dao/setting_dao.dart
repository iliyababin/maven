
import 'package:floor/floor.dart';

import '../model/setting.dart';

@dao
abstract class SettingDao {
  @Query('SELECT * FROM setting')
  Future<Setting?> getSetting();

  @Query('SELECT language_code FROM setting')
  Future<String?> getLanguageCode();

  @Query('SELECT country_code FROM setting')
  Future<String?> getCountryCode();

  @Query('SELECT theme_id FROM setting')
  Future<int?> getThemeId();

  @Query('SELECT username FROM setting')
  Future<String?> getUsername();

  @Query('SELECT description FROM setting')
  Future<String?> getDescription();

  @update
  Future<int> updateSetting(Setting setting);
}