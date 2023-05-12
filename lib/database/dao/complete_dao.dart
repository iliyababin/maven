
import 'package:floor/floor.dart';

import '../model/complete.dart';

@dao
abstract class CompleteDao {
  @insert
  Future<int> addComplete(Complete complete);

  @Query('SELECT * FROM complete')
  Future<List<Complete>> getCompletes();

  @Query('SELECT * FROM complete WHERE complete_id = :completeId')
  Future<Complete?> getComplete(int completeId);

  @update
  Future<int> updateComplete(Complete complete);

  @delete
  Future<int> deleteComplete(Complete complete);
}