import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class NoteDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(BaseNote note);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<BaseNote> notes);

  @Query('SELECT * FROM note WHERE id = :noteId')
  Future<BaseNote?> get(int noteId);

  @Query('SELECT * FROM note')
  Future<List<BaseNote>> getAll();

  @Query('SELECT * FROM note WHERE exercise_group_id = :exerciseGroupId')
  Future<List<BaseNote>> getByExerciseGroupId(int exerciseGroupId);

  @update
  Future<int> modify(BaseNote note);

  @delete
  Future<int> remove(BaseNote note);
}
