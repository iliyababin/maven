import 'package:floor/floor.dart';

import 'plate.dart';

@dao
abstract class PlateDao {
  @insert
  Future<int> add(Plate plate);

  @insert
  Future<List<int>> addAll(List<Plate> plates);

  @Query('SELECT * FROM plate WHERE id = :plateId')
  Future<Plate?> get(int plateId);

  @Query('SELECT * FROM plate ORDER BY weight DESC')
  Future<List<Plate>> getAll();

  @update
  Future<int> modify(Plate plate);

  @delete
  Future<int> remove(Plate plate);
}