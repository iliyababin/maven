
import 'package:floor/floor.dart';

import '../database.dart';

@dao
abstract class UserDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(User user);

  @Query('SELECT * FROM user WHERE id = :id')
  Future<User?> get(int id);

  @update
  Future<int> modify(User user);

  @delete
  Future<int> remove(User user);
}