import 'package:floor/floor.dart';

import '../model/plate.dart';

@dao
abstract class PlateDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addPlate(Plate plate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addPlates(List<Plate> plates);

  @Query('SELECT * FROM plate WHERE plate_id = :plateId')
  Future<Plate?> getPlate(int plateId);

  @Query('SELECT * FROM plate')
  Future<List<Plate>> getPlates();

  @Query('SELECT * FROM plate ORDER BY weight DESC')
  Stream<List<Plate>> getPlatesAsStream();

  @update
  Future<void> updatePlate(Plate plate);

  @delete
  Future<void> deletePlates(List<Plate> plates);

  @Query('DELETE FROM plate')
  Future<void> deleteAllPlates();
}