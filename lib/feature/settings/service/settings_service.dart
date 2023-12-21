import 'package:package_info_plus/package_info_plus.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';

class SettingsService {
  final SettingsDao settingDao;
  final AppThemeDao themeDao;
  final AppThemeColorDao themeColorDao;

  SettingsService({
    required this.settingDao,
    required this.themeDao,
    required this.themeColorDao,
  });

  /// Gets the current [PackageInfo].
  Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  /// Gets the current [SettingOLD].
  ///
  /// If the setting is not found, a new setting will be added.
  ///
  /// Throws an [Exception] if no setting was found and adding a new setting failed.
  Future<Settings> get() async {
    Settings? settings = await settingDao.get();

    if (settings == null) {
      await settingDao.add(const Settings.empty());

      Settings? updatedSettings = await settingDao.get();

      if (updatedSettings == null) {
        throw Exception('Tried to add a new setting but failed.');
      }

      return updatedSettings;
    }

    return settings;
  }

  /// Updates the current [Settings].
  ///
  /// Throws an [Exception] if the settings were not updated.
  Future<Settings> update(Settings settings) async {
    int rowsChanged = await settingDao.modify(settings);

    if (rowsChanged == 0) {
      throw Exception('Settings were not updated');
    }

    return get();
  }
}
