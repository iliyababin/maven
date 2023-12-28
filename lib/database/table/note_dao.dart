import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class NoteDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(Note note);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> addAll(List<Note> notes);

  @Query('SELECT * FROM note WHERE id = :noteId')
  Future<Note?> get(int noteId);

  @Query('SELECT * FROM note')
  Future<List<Note>> getAll();

  @Query('SELECT * FROM note WHERE exercise_group_id = :exerciseGroupId')
  Future<List<Note>> getByExerciseGroupId(int exerciseGroupId);

  @update
  Future<int> modify(Note note);

  @delete
  Future<int> remove(Note note);
}
