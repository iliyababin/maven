import 'package:floor/floor.dart';

import 'data.dart';

@dao
abstract class ImportDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(Import import);

  @Query('SELECT * FROM import WHERE id = :importId')
  Future<Import?> get(int importId);

  @Query('SELECT * FROM import')
  Future<List<Import>> getAll();

  @update
  Future<int> modify(Import import);

  @delete
  Future<int> remove(Import import);
}