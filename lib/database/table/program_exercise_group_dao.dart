import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class ProgramExerciseGroupDao {
  @insert
  Future<int> addProgramExerciseGroup(ProgramExerciseGroup programExerciseGroup);

  @Query('SELECT * FROM program_exercise_group WHERE id = :id')
  Future<ProgramExerciseGroup?> getProgramExerciseGroup(int id);

  @Query('SELECT * FROM program_exercise_group')
  Future<List<ProgramExerciseGroup>> getProgramExerciseGroups();

  @Query('SELECT * FROM program_exercise_group WHERE program_template_id = :programTemplateId')
  Future<List<ProgramExerciseGroup>> getProgramExerciseGroupsByProgramTemplateId(int programTemplateId);

  @update
  Future<int> updateProgramExerciseGroup(ProgramExerciseGroup programExerciseGroup);

  @delete
  Future<int> deleteProgramExerciseGroup(ProgramExerciseGroup programExerciseGroup);

}