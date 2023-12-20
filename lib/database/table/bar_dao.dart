
import 'package:floor/floor.dart';

import 'bar.dart';

@dao
abstract class BarDao {
  @insert
  Future<int> add(Bar bar);

  @insert
  Future<List<int>> addAll(List<Bar> bars);

  @Query('SELECT * FROM bar WHERE id = :barId')
  Future<Bar?> get(int barId);

  @Query('SELECT * FROM bar ORDER BY weight DESC')
  Future<List<Bar>> getAll();

  @update
  Future<int> modify(Bar bar);

  @delete
  Future<int> remove(Bar bar);
}