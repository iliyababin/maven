import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class RoutineDao {
  @insert
  Future<int> add(Routine routine);

  @Query('SELECT * FROM routine ORDER BY timestamp DESC')
  Future<List<Routine>> getAll();

  @Query('SELECT * FROM routine WHERE id = :routineId')
  Future<Routine?> get(int routineId);

  @Query('SELECT * FROM routine WHERE type = :type ORDER BY timestamp DESC')
  Future<List<Routine>> getByType(RoutineType type);

  @Query('SELECT * FROM routine WHERE sort = (SELECT MAX(sort) FROM routine) AND type = 0')
  Future<int?> getLargestSort();

  @update
  Future<int> modify(Routine routine);

  @delete
  Future<int> remove(Routine routine);
}