import 'package:floor/floor.dart';

import '../theme.dart';

@dao
abstract class AppThemeColorDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(AppThemeColor appThemeColor);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<AppThemeColor> appThemeColors);

  @Query('SELECT * FROM app_theme_color WHERE id = :appThemeColorId')
  Future<AppThemeColor?> get(int appThemeColorId);

  @Query('SELECT * FROM app_theme_color')
  Future<List<AppThemeColor>> getAll();

  @update
  Future<int> modify(AppThemeColor appThemeColor);

  @delete
  Future<int> remove(AppThemeColor appThemeColor);
}