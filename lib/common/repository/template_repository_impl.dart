import 'package:Maven/common/repository/template_repository.dart';
import 'package:Maven/common/util/database_helper.dart';

class TemplateRepositoryImpl implements TemplateRepository {

  final DBHelper _dbHelper;

  TemplateRepositoryImpl(this._dbHelper);

  @override
  Future<void> addTemplate() {
    // TODO: implement addTemplate
    throw UnimplementedError();
  }

  @override
  Future<void> getWorkout(int workoutId) {
    // TODO: implement getWorkout
    throw UnimplementedError();
  }
}