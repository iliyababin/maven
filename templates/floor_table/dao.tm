import 'package:floor/floor.dart';

import '{Table Name}[-s].dart';

@dao
abstract class {Table Name}[-C]Dao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add({Table Name}[-C] {Table Name}[-c]);

  @Query('SELECT * FROM {Table Name}[-s] WHERE id = :{Table Name}[-c]Id')
  Future<{Table Name}[-C]?> get(int {Table Name}[-c]Id);

  @Query('SELECT * FROM {Table Name}[-s]')
  Future<List<{Table Name}[-C]>> getAll();

  @update
  Future<int> modify({Table Name}[-C] {Table Name}[-c]);

  @delete
  Future<int> remove({Table Name}[-C] {Table Name}[-c]);
}