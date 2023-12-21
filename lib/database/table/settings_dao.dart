import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class SettingsDao {
  @insert
  Future<int> add(Settings settings);

  @Query('SELECT * FROM settings WHERE id = 1')
  Future<Settings?> get();

  @update
  Future<int> modify(Settings settings);

  @delete
  Future<int> remove(Settings settings);
}
