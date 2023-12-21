import 'package:flutter_test/flutter_test.dart';
import 'package:maven/database/database.dart';
import 'package:maven/feature/settings/service/settings_service.dart';
import 'package:maven/feature/theme/table/table.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingDao extends Mock implements SettingsDao {}

class MockAppThemeDao extends Mock implements AppThemeDao {}

class MockAppThemeColorDao extends Mock implements AppThemeColorDao {}

void main() {
  group('SettingsService', () {
    late SettingsDao settingDao;
    late AppThemeDao themeDao;
    late AppThemeColorDao themeColorDao;

    setUp(() {
      settingDao = MockSettingDao();
      themeDao = MockAppThemeDao();
      themeColorDao = MockAppThemeColorDao();
    });

    SettingsService build() {
      return SettingsService(
        settingsDao: settingDao,
        themeColorDao: themeColorDao,
        themeDao: themeDao,
      );
    }

    test('getPackageInfo', () {
      // TODO: Figure out how to test this.
    });

    test('get', () async {
      when(() => settingDao.get()).thenAnswer((_) async => null);
      when(() => settingDao.add(const Settings.empty())).thenAnswer((_) async => 1);
      when(() => settingDao.get()).thenAnswer((_) async => const Settings.empty());

      Settings settings = await build().get();

      expect(settings, const Settings.empty());
    });

    test('get throws exception if settings were not added', () async {
      when(() => settingDao.get()).thenAnswer((_) async => null);
      when(() => settingDao.add(const Settings.empty())).thenAnswer((_) async => 0);

      expect(() async => await build().get(), throwsException);
    });

    test('update', () async {
      when(() => settingDao.modify(const Settings.empty())).thenAnswer((_) async => 1);
      when(() => settingDao.get()).thenAnswer((_) async => const Settings.empty());

      Settings settings = await build().update(const Settings.empty());

      expect(settings, const Settings.empty());
    });

    test('update throws exception if settings were not updated', () async {
      when(() => settingDao.modify(const Settings.empty())).thenAnswer((_) async => 0);

      expect(() async => await build().update(const Settings.empty()), throwsException);
    });
  });
}
