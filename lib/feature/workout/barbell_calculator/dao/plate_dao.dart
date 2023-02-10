import 'package:floor/floor.dart';

import '../model/plate.dart';

@dao
abstract class PlateDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addPlate(Plate plate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addPlates(List<Plate> plates);

  @Query('SELECT * FROM plate')
  Future<List<Plate>> getPlates();

}