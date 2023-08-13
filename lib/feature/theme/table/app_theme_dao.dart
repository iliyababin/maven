import 'package:floor/floor.dart';

import 'app_theme.dart';

@dao
abstract class AppThemeDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(AppTheme appTheme);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<AppTheme> appThemes);

  @Query('SELECT * FROM app_theme WHERE id = :appThemeId')
  Future<AppTheme?> get(int appThemeId);

  @Query('SELECT * FROM app_theme')
  Future<List<AppTheme>> getAll();

  @update
  Future<int> modify(AppTheme appTheme);

  @delete
  Future<int> remove(AppTheme appTheme);
}