
import 'package:floor/floor.dart';

import '../model/bar.dart';

@dao
abstract class BarDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addBar(Bar bar);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addBars(List<Bar> bars);

  @Query('SELECT * FROM bar WHERE bar_id = :barId')
  Future<Bar?> getBar(int barId);

  @Query('SELECT * FROM bar')
  Future<List<Bar>> getBars();

  @Query('SELECT * FROM bar ORDER BY weight DESC')
  Stream<List<Bar>> getBarsAsStream();

  @update
  Future<void> updateBar(Bar bar);

  @delete
  Future<void> deleteBars(List<Bar> bars);

  @Query('DELETE FROM bar')
  Future<void> deleteAllBars();
}