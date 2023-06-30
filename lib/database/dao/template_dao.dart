import 'package:floor/floor.dart';

import '../model/template.dart';

@dao
abstract class TemplateDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> add(Template template);

  @insert
  Future<List<int>> addAll(List<Template> templates);

  @Query('SELECT * FROM template WHERE id = :templateId')
  Future<Template?> get(int templateId);

  // ORDER BY order ASC
  @Query('SELECT * FROM template')
  Future<List<Template>> getAll();


  @Query('SELECT sort_order FROM template')
  Future<List<int>> getSortOrder();

  @update
  Future<int> modify(Template template);

  @delete
  Future<int> remove(Template template);
}