
import 'package:floor/floor.dart';

import '../model/program.dart';

@dao
abstract class ProgramDao {
  @insert
  Future<int> addProgram(Program program);

  @Query('SELECT * FROM program WHERE program_id = :programId')
  Future<Program?> getProgram(int programId);

  @Query('SELECT * FROM program')
  Future<List<Program>> getPrograms();

  @Query('SELECT * FROM program')
  Stream<List<Program>> getProgramsAsStream();

  @update
  Future<int> updateProgram(Program program);

  @delete
  Future<int> deleteProgram(Program program);
}