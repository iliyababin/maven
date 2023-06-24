import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class ProgramDao {
  @insert
  Future<int> addProgram(Program program);

  @Query('SELECT * FROM program WHERE id = :id')
  Future<Program?> getProgram(int id);

  @Query('SELECT * FROM program')
  Future<List<Program>> getPrograms();

  @update
  Future<int> updateProgram(Program program);

  @delete
  Future<int> deleteProgram(Program program);
}
