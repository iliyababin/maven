import 'package:floor/floor.dart';

import 'data.dart';

@dao
abstract class ExportDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(Export export);

  @Query('SELECT * FROM export WHERE id = :exportId')
  Future<Export?> get(int exportId);

  @Query('SELECT * FROM export')
  Future<List<Export>> getAll();

  @update
  Future<int> modify(Export export);

  @delete
  Future<int> remove(Export export);
}