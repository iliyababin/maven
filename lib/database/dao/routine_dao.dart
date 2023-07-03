import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class RoutineDao {
  @insert
  Future<int> add(Routine routine);

  @Query('SELECT * FROM routine')
  Future<List<Routine>> getAll();

  @Query('SELECT * FROM routine WHERE id = :routineId')
  Future<Routine?> get(int routineId);

  @Query('SELECT * FROM routine WHERE type = :type')
  Future<List<Routine>> getByType(RoutineType type);

  @update
  Future<int> modify(Routine routine);

  @delete
  Future<int> remove(Routine routine);
}