
import 'package:floor/floor.dart';

import '../model/session.dart';

@dao
abstract class SessionDao {
  @insert
  Future<int> addSession(Session session);

  @Query('SELECT * FROM session')
  Future<List<Session>> getSessions();

  @Query('SELECT * FROM session WHERE id = :sessionId')
  Future<Session?> getSession(int sessionId);

  @update
  Future<int> updateSession(Session session);

  @delete
  Future<int> deleteSession(Session session);
}