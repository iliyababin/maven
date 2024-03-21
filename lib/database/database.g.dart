// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMavenDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MavenDatabaseBuilder databaseBuilder(String name) =>
      _$MavenDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MavenDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MavenDatabaseBuilder(null);
}

class _$MavenDatabaseBuilder {
  _$MavenDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MavenDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MavenDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MavenDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MavenDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MavenDatabase extends MavenDatabase {
  _$MavenDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BarDao? _barDaoInstance;

  ExerciseDao? _exerciseDaoInstance;

  ExerciseGroupDao? _baseExerciseGroupDaoInstance;

  ExerciseSetDao? _exerciseSetDaoInstance;

  ExerciseSetDataDao? _exerciseSetDataDaoInstance;

  ExerciseFieldDao? _exerciseFieldDaoInstance;

  PlateDao? _plateDaoInstance;

  ProgramDao? _programDaoInstance;

  ProgramExerciseGroupDao? _programExerciseGroupDaoInstance;

  ProgramFolderDao? _programFolderDaoInstance;

  ProgramTemplateDao? _programTemplateDaoInstance;

  RoutineDao? _routineDaoInstance;

  SettingsDao? _settingsDaoInstance;

  NoteDao? _noteDaoInstance;

  WorkoutDataDao? _workoutDataDaoInstance;

  SessionDataDao? _sessionDataDaoInstance;

  TemplateDataDao? _templateDataDaoInstance;

  UserDao? _userDaoInstance;

  ImportDao? _importDaoInstance;

  ExportDao? _exportDaoInstance;

  AppThemeDao? _themeDaoInstance;

  AppThemeColorDao? _themeColorDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `bar` (`id` INTEGER, `name` TEXT NOT NULL, `weight` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise` (`id` INTEGER, `name` TEXT NOT NULL, `muscle` INTEGER NOT NULL, `muscle_group` INTEGER NOT NULL, `equipment` INTEGER NOT NULL, `video_path` TEXT NOT NULL, `timer` INTEGER NOT NULL, `bar_id` INTEGER, `weight_unit` INTEGER, `distance_unit` INTEGER, `is_custom` INTEGER NOT NULL, `is_hidden` INTEGER NOT NULL, FOREIGN KEY (`bar_id`) REFERENCES `bar` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise_field` (`id` INTEGER, `type` INTEGER NOT NULL, `exercise_id` INTEGER NOT NULL, FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise_group` (`id` INTEGER, `timer` INTEGER NOT NULL, `weight_unit` INTEGER, `distance_unit` INTEGER, `exercise_id` INTEGER NOT NULL, `bar_id` INTEGER, `routine_id` INTEGER, FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`id`) ON UPDATE NO ACTION ON DELETE RESTRICT, FOREIGN KEY (`bar_id`) REFERENCES `bar` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`routine_id`) REFERENCES `routine` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise_set` (`id` INTEGER, `exercise_set_type` TEXT NOT NULL, `checked` INTEGER NOT NULL, `exercise_group_id` INTEGER NOT NULL, FOREIGN KEY (`exercise_group_id`) REFERENCES `exercise_group` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise_set_data` (`id` INTEGER, `value` TEXT NOT NULL, `field_type` INTEGER NOT NULL, `exercise_set_id` INTEGER NOT NULL, FOREIGN KEY (`exercise_set_id`) REFERENCES `exercise_set` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `plate` (`id` INTEGER, `weight` REAL NOT NULL, `amount` INTEGER NOT NULL, `color` INTEGER NOT NULL, `height` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `program` (`id` INTEGER, `name` TEXT NOT NULL, `timestamp` TEXT NOT NULL, `weeks` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `program_exercise_group` (`program_template_id` INTEGER NOT NULL, `id` INTEGER, `timer` INTEGER NOT NULL, `weight_unit` INTEGER, `distance_unit` INTEGER, `exercise_id` INTEGER NOT NULL, `bar_id` INTEGER, `routine_id` INTEGER, FOREIGN KEY (`bar_id`) REFERENCES `bar` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`exercise_id`) REFERENCES `exercise` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`program_template_id`) REFERENCES `program_template` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `program_folder` (`id` INTEGER, `order` INTEGER NOT NULL, `program_id` INTEGER NOT NULL, FOREIGN KEY (`program_id`) REFERENCES `program` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `program_template` (`day` INTEGER NOT NULL, `complete` INTEGER NOT NULL, `folder_id` INTEGER NOT NULL, `id` INTEGER, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `timestamp` TEXT NOT NULL, `type` INTEGER NOT NULL, FOREIGN KEY (`folder_id`) REFERENCES `program_folder` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `settings` (`id` INTEGER NOT NULL, `locale` TEXT NOT NULL, `theme_id` INTEGER NOT NULL, `unit` INTEGER NOT NULL, `session_weekly_goal` INTEGER NOT NULL, `use_system_default_theme` INTEGER NOT NULL, `use_dynamic_color` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `routine` (`id` INTEGER, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `timestamp` TEXT NOT NULL, `type` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `data` TEXT NOT NULL, `exercise_group_id` INTEGER NOT NULL, FOREIGN KEY (`exercise_group_id`) REFERENCES `exercise_group` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `workout_data` (`id` INTEGER, `is_active` INTEGER NOT NULL, `time_elapsed` INTEGER NOT NULL, `routine_id` INTEGER NOT NULL, FOREIGN KEY (`routine_id`) REFERENCES `routine` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `session_data` (`id` INTEGER, `time_elapsed` INTEGER NOT NULL, `routine_id` INTEGER NOT NULL, `import_id` INTEGER, FOREIGN KEY (`routine_id`) REFERENCES `routine` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`import_id`) REFERENCES `import` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `template_data` (`id` INTEGER, `sort` INTEGER NOT NULL, `routine_id` INTEGER NOT NULL, FOREIGN KEY (`routine_id`) REFERENCES `routine` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER NOT NULL, `username` TEXT NOT NULL, `description` TEXT NOT NULL, `gender` INTEGER NOT NULL, `height` REAL NOT NULL, `age` INTEGER NOT NULL, `created_at` TEXT NOT NULL, `picture` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `import` (`id` INTEGER, `timestamp` TEXT NOT NULL, `transfer_source` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `export` (`id` INTEGER, `date` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `app_theme` (`id` INTEGER, `name` TEXT NOT NULL, `brightness` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `app_theme_color` (`id` INTEGER, `app_theme_id` INTEGER NOT NULL, `primary` INTEGER NOT NULL, `on_primary` INTEGER NOT NULL, `primary_container` INTEGER NOT NULL, `on_primary_container` INTEGER NOT NULL, `secondary` INTEGER NOT NULL, `on_secondary` INTEGER NOT NULL, `secondary_container` INTEGER NOT NULL, `on_secondary_container` INTEGER NOT NULL, `background` INTEGER NOT NULL, `on_background` INTEGER NOT NULL, `surface` INTEGER NOT NULL, `on_surface` INTEGER NOT NULL, `on_surface_variant` INTEGER NOT NULL, `outline` INTEGER NOT NULL, `outline_variant` INTEGER NOT NULL, `inverse_primary` INTEGER NOT NULL, `inverse_surface` INTEGER NOT NULL, `on_inverse_surface` INTEGER NOT NULL, `success` INTEGER NOT NULL, `on_success` INTEGER NOT NULL, `success_container` INTEGER NOT NULL, `on_success_container` INTEGER NOT NULL, `error` INTEGER NOT NULL, `on_error` INTEGER NOT NULL, `error_container` INTEGER NOT NULL, `on_error_container` INTEGER NOT NULL, `shadow` INTEGER NOT NULL, `warmup` INTEGER NOT NULL, `drop` INTEGER NOT NULL, `cooldown` INTEGER NOT NULL, FOREIGN KEY (`app_theme_id`) REFERENCES `app_theme` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BarDao get barDao {
    return _barDaoInstance ??= _$BarDao(database, changeListener);
  }

  @override
  ExerciseDao get exerciseDao {
    return _exerciseDaoInstance ??= _$ExerciseDao(database, changeListener);
  }

  @override
  ExerciseGroupDao get baseExerciseGroupDao {
    return _baseExerciseGroupDaoInstance ??=
        _$ExerciseGroupDao(database, changeListener);
  }

  @override
  ExerciseSetDao get exerciseSetDao {
    return _exerciseSetDaoInstance ??=
        _$ExerciseSetDao(database, changeListener);
  }

  @override
  ExerciseSetDataDao get exerciseSetDataDao {
    return _exerciseSetDataDaoInstance ??=
        _$ExerciseSetDataDao(database, changeListener);
  }

  @override
  ExerciseFieldDao get exerciseFieldDao {
    return _exerciseFieldDaoInstance ??=
        _$ExerciseFieldDao(database, changeListener);
  }

  @override
  PlateDao get plateDao {
    return _plateDaoInstance ??= _$PlateDao(database, changeListener);
  }

  @override
  ProgramDao get programDao {
    return _programDaoInstance ??= _$ProgramDao(database, changeListener);
  }

  @override
  ProgramExerciseGroupDao get programExerciseGroupDao {
    return _programExerciseGroupDaoInstance ??=
        _$ProgramExerciseGroupDao(database, changeListener);
  }

  @override
  ProgramFolderDao get programFolderDao {
    return _programFolderDaoInstance ??=
        _$ProgramFolderDao(database, changeListener);
  }

  @override
  ProgramTemplateDao get programTemplateDao {
    return _programTemplateDaoInstance ??=
        _$ProgramTemplateDao(database, changeListener);
  }

  @override
  RoutineDao get routineDao {
    return _routineDaoInstance ??= _$RoutineDao(database, changeListener);
  }

  @override
  SettingsDao get settingsDao {
    return _settingsDaoInstance ??= _$SettingsDao(database, changeListener);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  WorkoutDataDao get workoutDataDao {
    return _workoutDataDaoInstance ??=
        _$WorkoutDataDao(database, changeListener);
  }

  @override
  SessionDataDao get sessionDataDao {
    return _sessionDataDaoInstance ??=
        _$SessionDataDao(database, changeListener);
  }

  @override
  TemplateDataDao get templateDataDao {
    return _templateDataDaoInstance ??=
        _$TemplateDataDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  ImportDao get importDao {
    return _importDaoInstance ??= _$ImportDao(database, changeListener);
  }

  @override
  ExportDao get exportDao {
    return _exportDaoInstance ??= _$ExportDao(database, changeListener);
  }

  @override
  AppThemeDao get themeDao {
    return _themeDaoInstance ??= _$AppThemeDao(database, changeListener);
  }

  @override
  AppThemeColorDao get themeColorDao {
    return _themeColorDaoInstance ??=
        _$AppThemeColorDao(database, changeListener);
  }
}

class _$BarDao extends BarDao {
  _$BarDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _barInsertionAdapter = InsertionAdapter(
            database,
            'bar',
            (Bar item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'weight': item.weight
                }),
        _barUpdateAdapter = UpdateAdapter(
            database,
            'bar',
            ['id'],
            (Bar item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'weight': item.weight
                }),
        _barDeletionAdapter = DeletionAdapter(
            database,
            'bar',
            ['id'],
            (Bar item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'weight': item.weight
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Bar> _barInsertionAdapter;

  final UpdateAdapter<Bar> _barUpdateAdapter;

  final DeletionAdapter<Bar> _barDeletionAdapter;

  @override
  Future<Bar?> get(int barId) async {
    return _queryAdapter.query('SELECT * FROM bar WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Bar(
            id: row['id'] as int?,
            name: row['name'] as String,
            weight: row['weight'] as double),
        arguments: [barId]);
  }

  @override
  Future<List<Bar>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM bar ORDER BY weight DESC',
        mapper: (Map<String, Object?> row) => Bar(
            id: row['id'] as int?,
            name: row['name'] as String,
            weight: row['weight'] as double));
  }

  @override
  Future<int> add(Bar bar) {
    return _barInsertionAdapter.insertAndReturnId(
        bar, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> addAll(List<Bar> bars) {
    return _barInsertionAdapter.insertListAndReturnIds(
        bars, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(Bar bar) {
    return _barUpdateAdapter.updateAndReturnChangedRows(
        bar, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Bar bar) {
    return _barDeletionAdapter.deleteAndReturnChangedRows(bar);
  }
}

class _$ExerciseDao extends ExerciseDao {
  _$ExerciseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exerciseInsertionAdapter = InsertionAdapter(
            database,
            'exercise',
            (Exercise item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'muscle': item.muscle.index,
                  'muscle_group': item.muscleGroup.index,
                  'equipment': item.equipment.index,
                  'video_path': item.videoPath,
                  'timer': _timedConverter.encode(item.timer),
                  'bar_id': item.barId,
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'is_custom': item.isCustom ? 1 : 0,
                  'is_hidden': item.isHidden ? 1 : 0
                }),
        _exerciseUpdateAdapter = UpdateAdapter(
            database,
            'exercise',
            ['id'],
            (Exercise item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'muscle': item.muscle.index,
                  'muscle_group': item.muscleGroup.index,
                  'equipment': item.equipment.index,
                  'video_path': item.videoPath,
                  'timer': _timedConverter.encode(item.timer),
                  'bar_id': item.barId,
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'is_custom': item.isCustom ? 1 : 0,
                  'is_hidden': item.isHidden ? 1 : 0
                }),
        _exerciseDeletionAdapter = DeletionAdapter(
            database,
            'exercise',
            ['id'],
            (Exercise item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'muscle': item.muscle.index,
                  'muscle_group': item.muscleGroup.index,
                  'equipment': item.equipment.index,
                  'video_path': item.videoPath,
                  'timer': _timedConverter.encode(item.timer),
                  'bar_id': item.barId,
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'is_custom': item.isCustom ? 1 : 0,
                  'is_hidden': item.isHidden ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Exercise> _exerciseInsertionAdapter;

  final UpdateAdapter<Exercise> _exerciseUpdateAdapter;

  final DeletionAdapter<Exercise> _exerciseDeletionAdapter;

  @override
  Future<Exercise?> get(int exerciseId) async {
    return _queryAdapter.query('SELECT * FROM exercise WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Exercise(
            id: row['id'] as int?,
            name: row['name'] as String,
            muscle: Muscle.values[row['muscle'] as int],
            muscleGroup: MuscleGroup.values[row['muscle_group'] as int],
            equipment: Equipment.values[row['equipment'] as int],
            videoPath: row['video_path'] as String,
            timer: _timedConverter.decode(row['timer'] as int),
            barId: row['bar_id'] as int?,
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            isCustom: (row['is_custom'] as int) != 0,
            isHidden: (row['is_hidden'] as int) != 0),
        arguments: [exerciseId]);
  }

  @override
  Future<List<Exercise>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM exercise ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => Exercise(
            id: row['id'] as int?,
            name: row['name'] as String,
            muscle: Muscle.values[row['muscle'] as int],
            muscleGroup: MuscleGroup.values[row['muscle_group'] as int],
            equipment: Equipment.values[row['equipment'] as int],
            videoPath: row['video_path'] as String,
            timer: _timedConverter.decode(row['timer'] as int),
            barId: row['bar_id'] as int?,
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            isCustom: (row['is_custom'] as int) != 0,
            isHidden: (row['is_hidden'] as int) != 0));
  }

  @override
  Future<int> add(Exercise exercise) {
    return _exerciseInsertionAdapter.insertAndReturnId(
        exercise, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> addAll(List<Exercise> exercises) {
    return _exerciseInsertionAdapter.insertListAndReturnIds(
        exercises, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(Exercise exercise) {
    return _exerciseUpdateAdapter.updateAndReturnChangedRows(
        exercise, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Exercise exercise) {
    return _exerciseDeletionAdapter.deleteAndReturnChangedRows(exercise);
  }
}

class _$ExerciseGroupDao extends ExerciseGroupDao {
  _$ExerciseGroupDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _baseExerciseGroupInsertionAdapter = InsertionAdapter(
            database,
            'exercise_group',
            (BaseExerciseGroup item) => <String, Object?>{
                  'id': item.id,
                  'timer': _timedConverter.encode(item.timer),
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'exercise_id': item.exerciseId,
                  'bar_id': item.barId,
                  'routine_id': item.routineId
                }),
        _baseExerciseGroupUpdateAdapter = UpdateAdapter(
            database,
            'exercise_group',
            ['id'],
            (BaseExerciseGroup item) => <String, Object?>{
                  'id': item.id,
                  'timer': _timedConverter.encode(item.timer),
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'exercise_id': item.exerciseId,
                  'bar_id': item.barId,
                  'routine_id': item.routineId
                }),
        _baseExerciseGroupDeletionAdapter = DeletionAdapter(
            database,
            'exercise_group',
            ['id'],
            (BaseExerciseGroup item) => <String, Object?>{
                  'id': item.id,
                  'timer': _timedConverter.encode(item.timer),
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'exercise_id': item.exerciseId,
                  'bar_id': item.barId,
                  'routine_id': item.routineId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BaseExerciseGroup> _baseExerciseGroupInsertionAdapter;

  final UpdateAdapter<BaseExerciseGroup> _baseExerciseGroupUpdateAdapter;

  final DeletionAdapter<BaseExerciseGroup> _baseExerciseGroupDeletionAdapter;

  @override
  Future<BaseExerciseGroup?> get(int exerciseGroupId) async {
    return _queryAdapter.query('SELECT * FROM exercise_group WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BaseExerciseGroup(
            id: row['id'] as int?,
            timer: _timedConverter.decode(row['timer'] as int),
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            exerciseId: row['exercise_id'] as int,
            barId: row['bar_id'] as int?,
            routineId: row['routine_id'] as int?),
        arguments: [exerciseGroupId]);
  }

  @override
  Future<List<BaseExerciseGroup>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM exercise_group',
        mapper: (Map<String, Object?> row) => BaseExerciseGroup(
            id: row['id'] as int?,
            timer: _timedConverter.decode(row['timer'] as int),
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            exerciseId: row['exercise_id'] as int,
            barId: row['bar_id'] as int?,
            routineId: row['routine_id'] as int?));
  }

  @override
  Future<List<BaseExerciseGroup>> getByRoutineId(int routineId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM exercise_group WHERE routine_id = ?1',
        mapper: (Map<String, Object?> row) => BaseExerciseGroup(
            id: row['id'] as int?,
            timer: _timedConverter.decode(row['timer'] as int),
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            exerciseId: row['exercise_id'] as int,
            barId: row['bar_id'] as int?,
            routineId: row['routine_id'] as int?),
        arguments: [routineId]);
  }

  @override
  Future<List<int>> getSortOrder() async {
    return _queryAdapter.queryList('SELECT sort FROM exercise_group',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> add(BaseExerciseGroup exerciseGroup) {
    return _baseExerciseGroupInsertionAdapter.insertAndReturnId(
        exerciseGroup, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<BaseExerciseGroup> exerciseGroups) {
    return _baseExerciseGroupInsertionAdapter.insertListAndReturnIds(
        exerciseGroups, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(BaseExerciseGroup exerciseGroup) {
    return _baseExerciseGroupUpdateAdapter.updateAndReturnChangedRows(
        exerciseGroup, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(BaseExerciseGroup exerciseGroup) {
    return _baseExerciseGroupDeletionAdapter
        .deleteAndReturnChangedRows(exerciseGroup);
  }
}

class _$ExerciseSetDao extends ExerciseSetDao {
  _$ExerciseSetDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _baseExerciseSetInsertionAdapter = InsertionAdapter(
            database,
            'exercise_set',
            (BaseExerciseSet item) => <String, Object?>{
                  'id': item.id,
                  'exercise_set_type': _setTypeConverter.encode(item.type),
                  'checked': item.checked ? 1 : 0,
                  'exercise_group_id': item.exerciseGroupId
                }),
        _baseExerciseSetUpdateAdapter = UpdateAdapter(
            database,
            'exercise_set',
            ['id'],
            (BaseExerciseSet item) => <String, Object?>{
                  'id': item.id,
                  'exercise_set_type': _setTypeConverter.encode(item.type),
                  'checked': item.checked ? 1 : 0,
                  'exercise_group_id': item.exerciseGroupId
                }),
        _baseExerciseSetDeletionAdapter = DeletionAdapter(
            database,
            'exercise_set',
            ['id'],
            (BaseExerciseSet item) => <String, Object?>{
                  'id': item.id,
                  'exercise_set_type': _setTypeConverter.encode(item.type),
                  'checked': item.checked ? 1 : 0,
                  'exercise_group_id': item.exerciseGroupId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BaseExerciseSet> _baseExerciseSetInsertionAdapter;

  final UpdateAdapter<BaseExerciseSet> _baseExerciseSetUpdateAdapter;

  final DeletionAdapter<BaseExerciseSet> _baseExerciseSetDeletionAdapter;

  @override
  Future<BaseExerciseSet?> get(int exerciseSetId) async {
    return _queryAdapter.query('SELECT * FROM exercise_set WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BaseExerciseSet(
            id: row['id'] as int?,
            type: _setTypeConverter.decode(row['exercise_set_type'] as String),
            checked: (row['checked'] as int) != 0,
            exerciseGroupId: row['exercise_group_id'] as int),
        arguments: [exerciseSetId]);
  }

  @override
  Future<List<BaseExerciseSet>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM exercise_set',
        mapper: (Map<String, Object?> row) => BaseExerciseSet(
            id: row['id'] as int?,
            type: _setTypeConverter.decode(row['exercise_set_type'] as String),
            checked: (row['checked'] as int) != 0,
            exerciseGroupId: row['exercise_group_id'] as int));
  }

  @override
  Future<List<BaseExerciseSet>> getByExerciseGroupId(
      int exerciseGroupId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM exercise_set WHERE exercise_group_id = ?1',
        mapper: (Map<String, Object?> row) => BaseExerciseSet(
            id: row['id'] as int?,
            type: _setTypeConverter.decode(row['exercise_set_type'] as String),
            checked: (row['checked'] as int) != 0,
            exerciseGroupId: row['exercise_group_id'] as int),
        arguments: [exerciseGroupId]);
  }

  @override
  Future<List<int>> getSortOrder() async {
    return _queryAdapter.queryList('SELECT sort FROM exercise_set',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> add(BaseExerciseSet exerciseSet) {
    return _baseExerciseSetInsertionAdapter.insertAndReturnId(
        exerciseSet, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<BaseExerciseSet> exerciseSets) {
    return _baseExerciseSetInsertionAdapter.insertListAndReturnIds(
        exerciseSets, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(BaseExerciseSet exerciseSet) {
    return _baseExerciseSetUpdateAdapter.updateAndReturnChangedRows(
        exerciseSet, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(BaseExerciseSet exerciseSet) {
    return _baseExerciseSetDeletionAdapter
        .deleteAndReturnChangedRows(exerciseSet);
  }
}

class _$ExerciseSetDataDao extends ExerciseSetDataDao {
  _$ExerciseSetDataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _baseExerciseSetDataInsertionAdapter = InsertionAdapter(
            database,
            'exercise_set_data',
            (BaseExerciseSetData item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'field_type': item.fieldType.index,
                  'exercise_set_id': item.exerciseSetId
                }),
        _baseExerciseSetDataUpdateAdapter = UpdateAdapter(
            database,
            'exercise_set_data',
            ['id'],
            (BaseExerciseSetData item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'field_type': item.fieldType.index,
                  'exercise_set_id': item.exerciseSetId
                }),
        _baseExerciseSetDataDeletionAdapter = DeletionAdapter(
            database,
            'exercise_set_data',
            ['id'],
            (BaseExerciseSetData item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'field_type': item.fieldType.index,
                  'exercise_set_id': item.exerciseSetId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BaseExerciseSetData>
      _baseExerciseSetDataInsertionAdapter;

  final UpdateAdapter<BaseExerciseSetData> _baseExerciseSetDataUpdateAdapter;

  final DeletionAdapter<BaseExerciseSetData>
      _baseExerciseSetDataDeletionAdapter;

  @override
  Future<BaseExerciseSetData?> get(int exerciseSetId) async {
    return _queryAdapter.query('SELECT * FROM exercise_set WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BaseExerciseSetData(
            id: row['id'] as int?,
            value: row['value'] as String,
            fieldType: ExerciseFieldType.values[row['field_type'] as int],
            exerciseSetId: row['exercise_set_id'] as int),
        arguments: [exerciseSetId]);
  }

  @override
  Future<List<BaseExerciseSetData>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM exercise_set',
        mapper: (Map<String, Object?> row) => BaseExerciseSetData(
            id: row['id'] as int?,
            value: row['value'] as String,
            fieldType: ExerciseFieldType.values[row['field_type'] as int],
            exerciseSetId: row['exercise_set_id'] as int));
  }

  @override
  Future<List<BaseExerciseSetData>> getByExerciseSetId(
      int exerciseSetId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM exercise_set_data WHERE exercise_set_id = ?1',
        mapper: (Map<String, Object?> row) => BaseExerciseSetData(
            id: row['id'] as int?,
            value: row['value'] as String,
            fieldType: ExerciseFieldType.values[row['field_type'] as int],
            exerciseSetId: row['exercise_set_id'] as int),
        arguments: [exerciseSetId]);
  }

  @override
  Future<List<int>> getSortOrder() async {
    return _queryAdapter.queryList('SELECT sort FROM exercise_set',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> add(BaseExerciseSetData exerciseSet) {
    return _baseExerciseSetDataInsertionAdapter.insertAndReturnId(
        exerciseSet, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<BaseExerciseSetData> exerciseSets) {
    return _baseExerciseSetDataInsertionAdapter.insertListAndReturnIds(
        exerciseSets, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(BaseExerciseSetData exerciseSet) {
    return _baseExerciseSetDataUpdateAdapter.updateAndReturnChangedRows(
        exerciseSet, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(BaseExerciseSetData exerciseSet) {
    return _baseExerciseSetDataDeletionAdapter
        .deleteAndReturnChangedRows(exerciseSet);
  }
}

class _$ExerciseFieldDao extends ExerciseFieldDao {
  _$ExerciseFieldDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exerciseFieldInsertionAdapter = InsertionAdapter(
            database,
            'exercise_field',
            (ExerciseField item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type.index,
                  'exercise_id': item.exerciseId
                }),
        _exerciseFieldUpdateAdapter = UpdateAdapter(
            database,
            'exercise_field',
            ['id'],
            (ExerciseField item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type.index,
                  'exercise_id': item.exerciseId
                }),
        _exerciseFieldDeletionAdapter = DeletionAdapter(
            database,
            'exercise_field',
            ['id'],
            (ExerciseField item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type.index,
                  'exercise_id': item.exerciseId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExerciseField> _exerciseFieldInsertionAdapter;

  final UpdateAdapter<ExerciseField> _exerciseFieldUpdateAdapter;

  final DeletionAdapter<ExerciseField> _exerciseFieldDeletionAdapter;

  @override
  Future<ExerciseField?> get(int id) async {
    return _queryAdapter.query('SELECT * FROM exercise_field WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ExerciseField(
            id: row['id'] as int?,
            exerciseId: row['exercise_id'] as int,
            type: ExerciseFieldType.values[row['type'] as int]),
        arguments: [id]);
  }

  @override
  Future<List<ExerciseField>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM exercise_field',
        mapper: (Map<String, Object?> row) => ExerciseField(
            id: row['id'] as int?,
            exerciseId: row['exercise_id'] as int,
            type: ExerciseFieldType.values[row['type'] as int]));
  }

  @override
  Future<List<ExerciseField>> getByExerciseId(int exerciseId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM exercise_field WHERE exercise_id = ?1',
        mapper: (Map<String, Object?> row) => ExerciseField(
            id: row['id'] as int?,
            exerciseId: row['exercise_id'] as int,
            type: ExerciseFieldType.values[row['type'] as int]),
        arguments: [exerciseId]);
  }

  @override
  Future<int> add(ExerciseField exerciseField) {
    return _exerciseFieldInsertionAdapter.insertAndReturnId(
        exerciseField, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> addAll(List<ExerciseField> exerciseFields) {
    return _exerciseFieldInsertionAdapter.insertListAndReturnIds(
        exerciseFields, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateExerciseField(ExerciseField exerciseField) {
    return _exerciseFieldUpdateAdapter.updateAndReturnChangedRows(
        exerciseField, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteExerciseField(ExerciseField exerciseField) {
    return _exerciseFieldDeletionAdapter
        .deleteAndReturnChangedRows(exerciseField);
  }
}

class _$PlateDao extends PlateDao {
  _$PlateDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _plateInsertionAdapter = InsertionAdapter(
            database,
            'plate',
            (Plate item) => <String, Object?>{
                  'id': item.id,
                  'weight': item.weight,
                  'amount': item.amount,
                  'color': _colorConverter.encode(item.color),
                  'height': item.height
                }),
        _plateUpdateAdapter = UpdateAdapter(
            database,
            'plate',
            ['id'],
            (Plate item) => <String, Object?>{
                  'id': item.id,
                  'weight': item.weight,
                  'amount': item.amount,
                  'color': _colorConverter.encode(item.color),
                  'height': item.height
                }),
        _plateDeletionAdapter = DeletionAdapter(
            database,
            'plate',
            ['id'],
            (Plate item) => <String, Object?>{
                  'id': item.id,
                  'weight': item.weight,
                  'amount': item.amount,
                  'color': _colorConverter.encode(item.color),
                  'height': item.height
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Plate> _plateInsertionAdapter;

  final UpdateAdapter<Plate> _plateUpdateAdapter;

  final DeletionAdapter<Plate> _plateDeletionAdapter;

  @override
  Future<Plate?> get(int plateId) async {
    return _queryAdapter.query('SELECT * FROM plate WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Plate(
            id: row['id'] as int?,
            weight: row['weight'] as double,
            amount: row['amount'] as int,
            color: _colorConverter.decode(row['color'] as int),
            height: row['height'] as double),
        arguments: [plateId]);
  }

  @override
  Future<List<Plate>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM plate ORDER BY weight DESC',
        mapper: (Map<String, Object?> row) => Plate(
            id: row['id'] as int?,
            weight: row['weight'] as double,
            amount: row['amount'] as int,
            color: _colorConverter.decode(row['color'] as int),
            height: row['height'] as double));
  }

  @override
  Future<int> add(Plate plate) {
    return _plateInsertionAdapter.insertAndReturnId(
        plate, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> addAll(List<Plate> plates) {
    return _plateInsertionAdapter.insertListAndReturnIds(
        plates, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(Plate plate) {
    return _plateUpdateAdapter.updateAndReturnChangedRows(
        plate, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Plate plate) {
    return _plateDeletionAdapter.deleteAndReturnChangedRows(plate);
  }
}

class _$ProgramDao extends ProgramDao {
  _$ProgramDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _programInsertionAdapter = InsertionAdapter(
            database,
            'program',
            (Program item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'weeks': item.weeks
                }),
        _programUpdateAdapter = UpdateAdapter(
            database,
            'program',
            ['id'],
            (Program item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'weeks': item.weeks
                }),
        _programDeletionAdapter = DeletionAdapter(
            database,
            'program',
            ['id'],
            (Program item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'weeks': item.weeks
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Program> _programInsertionAdapter;

  final UpdateAdapter<Program> _programUpdateAdapter;

  final DeletionAdapter<Program> _programDeletionAdapter;

  @override
  Future<Program?> getProgram(int id) async {
    return _queryAdapter.query('SELECT * FROM program WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Program(
            id: row['id'] as int?,
            name: row['name'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            weeks: row['weeks'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Program>> getPrograms() async {
    return _queryAdapter.queryList('SELECT * FROM program',
        mapper: (Map<String, Object?> row) => Program(
            id: row['id'] as int?,
            name: row['name'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            weeks: row['weeks'] as int));
  }

  @override
  Future<int> addProgram(Program program) {
    return _programInsertionAdapter.insertAndReturnId(
        program, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateProgram(Program program) {
    return _programUpdateAdapter.updateAndReturnChangedRows(
        program, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProgram(Program program) {
    return _programDeletionAdapter.deleteAndReturnChangedRows(program);
  }
}

class _$ProgramExerciseGroupDao extends ProgramExerciseGroupDao {
  _$ProgramExerciseGroupDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _programExerciseGroupInsertionAdapter = InsertionAdapter(
            database,
            'program_exercise_group',
            (ProgramExerciseGroup item) => <String, Object?>{
                  'program_template_id': item.programTemplateId,
                  'id': item.id,
                  'timer': _timedConverter.encode(item.timer),
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'exercise_id': item.exerciseId,
                  'bar_id': item.barId,
                  'routine_id': item.routineId
                }),
        _programExerciseGroupUpdateAdapter = UpdateAdapter(
            database,
            'program_exercise_group',
            ['id'],
            (ProgramExerciseGroup item) => <String, Object?>{
                  'program_template_id': item.programTemplateId,
                  'id': item.id,
                  'timer': _timedConverter.encode(item.timer),
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'exercise_id': item.exerciseId,
                  'bar_id': item.barId,
                  'routine_id': item.routineId
                }),
        _programExerciseGroupDeletionAdapter = DeletionAdapter(
            database,
            'program_exercise_group',
            ['id'],
            (ProgramExerciseGroup item) => <String, Object?>{
                  'program_template_id': item.programTemplateId,
                  'id': item.id,
                  'timer': _timedConverter.encode(item.timer),
                  'weight_unit': item.weightUnit?.index,
                  'distance_unit': item.distanceUnit?.index,
                  'exercise_id': item.exerciseId,
                  'bar_id': item.barId,
                  'routine_id': item.routineId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProgramExerciseGroup>
      _programExerciseGroupInsertionAdapter;

  final UpdateAdapter<ProgramExerciseGroup> _programExerciseGroupUpdateAdapter;

  final DeletionAdapter<ProgramExerciseGroup>
      _programExerciseGroupDeletionAdapter;

  @override
  Future<ProgramExerciseGroup?> getProgramExerciseGroup(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM program_exercise_group WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProgramExerciseGroup(
            id: row['id'] as int?,
            timer: _timedConverter.decode(row['timer'] as int),
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            exerciseId: row['exercise_id'] as int,
            barId: row['bar_id'] as int?,
            programTemplateId: row['program_template_id'] as int,
            routineId: row['routine_id'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<ProgramExerciseGroup>> getProgramExerciseGroups() async {
    return _queryAdapter.queryList('SELECT * FROM program_exercise_group',
        mapper: (Map<String, Object?> row) => ProgramExerciseGroup(
            id: row['id'] as int?,
            timer: _timedConverter.decode(row['timer'] as int),
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            exerciseId: row['exercise_id'] as int,
            barId: row['bar_id'] as int?,
            programTemplateId: row['program_template_id'] as int,
            routineId: row['routine_id'] as int?));
  }

  @override
  Future<List<ProgramExerciseGroup>>
      getProgramExerciseGroupsByProgramTemplateId(int programTemplateId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM program_exercise_group WHERE program_template_id = ?1',
        mapper: (Map<String, Object?> row) => ProgramExerciseGroup(
            id: row['id'] as int?,
            timer: _timedConverter.decode(row['timer'] as int),
            weightUnit: row['weight_unit'] == null
                ? null
                : WeightUnit.values[row['weight_unit'] as int],
            distanceUnit: row['distance_unit'] == null
                ? null
                : DistanceUnit.values[row['distance_unit'] as int],
            exerciseId: row['exercise_id'] as int,
            barId: row['bar_id'] as int?,
            programTemplateId: row['program_template_id'] as int,
            routineId: row['routine_id'] as int?),
        arguments: [programTemplateId]);
  }

  @override
  Future<int> addProgramExerciseGroup(
      ProgramExerciseGroup programExerciseGroup) {
    return _programExerciseGroupInsertionAdapter.insertAndReturnId(
        programExerciseGroup, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateProgramExerciseGroup(
      ProgramExerciseGroup programExerciseGroup) {
    return _programExerciseGroupUpdateAdapter.updateAndReturnChangedRows(
        programExerciseGroup, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProgramExerciseGroup(
      ProgramExerciseGroup programExerciseGroup) {
    return _programExerciseGroupDeletionAdapter
        .deleteAndReturnChangedRows(programExerciseGroup);
  }
}

class _$ProgramFolderDao extends ProgramFolderDao {
  _$ProgramFolderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _programFolderInsertionAdapter = InsertionAdapter(
            database,
            'program_folder',
            (ProgramFolder item) => <String, Object?>{
                  'id': item.id,
                  'order': item.order,
                  'program_id': item.programId
                }),
        _programFolderUpdateAdapter = UpdateAdapter(
            database,
            'program_folder',
            ['id'],
            (ProgramFolder item) => <String, Object?>{
                  'id': item.id,
                  'order': item.order,
                  'program_id': item.programId
                }),
        _programFolderDeletionAdapter = DeletionAdapter(
            database,
            'program_folder',
            ['id'],
            (ProgramFolder item) => <String, Object?>{
                  'id': item.id,
                  'order': item.order,
                  'program_id': item.programId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProgramFolder> _programFolderInsertionAdapter;

  final UpdateAdapter<ProgramFolder> _programFolderUpdateAdapter;

  final DeletionAdapter<ProgramFolder> _programFolderDeletionAdapter;

  @override
  Future<ProgramFolder?> getProgramFolder(int id) async {
    return _queryAdapter.query('SELECT * FROM program_folder WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProgramFolder(
            id: row['id'] as int?,
            order: row['order'] as int,
            programId: row['program_id'] as int),
        arguments: [id]);
  }

  @override
  Future<List<ProgramFolder>> getProgramFolders() async {
    return _queryAdapter.queryList('SELECT * FROM program_folder',
        mapper: (Map<String, Object?> row) => ProgramFolder(
            id: row['id'] as int?,
            order: row['order'] as int,
            programId: row['program_id'] as int));
  }

  @override
  Future<List<ProgramFolder>> getProgramFoldersByProgramId(
      int programId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM program_folder WHERE program_id = ?1',
        mapper: (Map<String, Object?> row) => ProgramFolder(
            id: row['id'] as int?,
            order: row['order'] as int,
            programId: row['program_id'] as int),
        arguments: [programId]);
  }

  @override
  Future<int> addProgramFolder(ProgramFolder programFolder) {
    return _programFolderInsertionAdapter.insertAndReturnId(
        programFolder, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateProgramFolder(ProgramFolder programFolder) {
    return _programFolderUpdateAdapter.updateAndReturnChangedRows(
        programFolder, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProgramFolder(ProgramFolder programFolder) {
    return _programFolderDeletionAdapter
        .deleteAndReturnChangedRows(programFolder);
  }
}

class _$ProgramTemplateDao extends ProgramTemplateDao {
  _$ProgramTemplateDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _programTemplateInsertionAdapter = InsertionAdapter(
            database,
            'program_template',
            (ProgramTemplate item) => <String, Object?>{
                  'day': item.day.index,
                  'complete': item.complete ? 1 : 0,
                  'folder_id': item.folderId,
                  'id': item.id,
                  'name': item.name,
                  'description': item.note,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'type': item.type.index
                }),
        _programTemplateUpdateAdapter = UpdateAdapter(
            database,
            'program_template',
            ['id'],
            (ProgramTemplate item) => <String, Object?>{
                  'day': item.day.index,
                  'complete': item.complete ? 1 : 0,
                  'folder_id': item.folderId,
                  'id': item.id,
                  'name': item.name,
                  'description': item.note,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'type': item.type.index
                }),
        _programTemplateDeletionAdapter = DeletionAdapter(
            database,
            'program_template',
            ['id'],
            (ProgramTemplate item) => <String, Object?>{
                  'day': item.day.index,
                  'complete': item.complete ? 1 : 0,
                  'folder_id': item.folderId,
                  'id': item.id,
                  'name': item.name,
                  'description': item.note,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'type': item.type.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProgramTemplate> _programTemplateInsertionAdapter;

  final UpdateAdapter<ProgramTemplate> _programTemplateUpdateAdapter;

  final DeletionAdapter<ProgramTemplate> _programTemplateDeletionAdapter;

  @override
  Future<ProgramTemplate?> getProgramTemplate(int id) async {
    return _queryAdapter.query('SELECT * FROM program_template WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProgramTemplate(
            id: row['id'] as int?,
            name: row['name'] as String,
            note: row['description'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            day: Day.values[row['day'] as int],
            complete: (row['complete'] as int) != 0,
            folderId: row['folder_id'] as int,
            type: RoutineType.values[row['type'] as int]),
        arguments: [id]);
  }

  @override
  Future<List<ProgramTemplate>> getProgramTemplates() async {
    return _queryAdapter.queryList('SELECT * FROM program_template',
        mapper: (Map<String, Object?> row) => ProgramTemplate(
            id: row['id'] as int?,
            name: row['name'] as String,
            note: row['description'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            day: Day.values[row['day'] as int],
            complete: (row['complete'] as int) != 0,
            folderId: row['folder_id'] as int,
            type: RoutineType.values[row['type'] as int]));
  }

  @override
  Future<List<ProgramTemplate>> getProgramTemplatesByFolderId(
      int folderId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM program_template WHERE folder_id = ?1',
        mapper: (Map<String, Object?> row) => ProgramTemplate(
            id: row['id'] as int?,
            name: row['name'] as String,
            note: row['description'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            day: Day.values[row['day'] as int],
            complete: (row['complete'] as int) != 0,
            folderId: row['folder_id'] as int,
            type: RoutineType.values[row['type'] as int]),
        arguments: [folderId]);
  }

  @override
  Future<int> addProgramTemplate(ProgramTemplate programTemplate) {
    return _programTemplateInsertionAdapter.insertAndReturnId(
        programTemplate, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateProgramTemplate(ProgramTemplate programTemplate) {
    return _programTemplateUpdateAdapter.updateAndReturnChangedRows(
        programTemplate, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProgramTemplate(ProgramTemplate programTemplate) {
    return _programTemplateDeletionAdapter
        .deleteAndReturnChangedRows(programTemplate);
  }
}

class _$RoutineDao extends RoutineDao {
  _$RoutineDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _routineInsertionAdapter = InsertionAdapter(
            database,
            'routine',
            (Routine item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.note,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'type': item.type.index
                }),
        _routineUpdateAdapter = UpdateAdapter(
            database,
            'routine',
            ['id'],
            (Routine item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.note,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'type': item.type.index
                }),
        _routineDeletionAdapter = DeletionAdapter(
            database,
            'routine',
            ['id'],
            (Routine item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.note,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'type': item.type.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Routine> _routineInsertionAdapter;

  final UpdateAdapter<Routine> _routineUpdateAdapter;

  final DeletionAdapter<Routine> _routineDeletionAdapter;

  @override
  Future<List<Routine>> getAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM routine ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => Routine(
            id: row['id'] as int?,
            name: row['name'] as String,
            note: row['description'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            type: RoutineType.values[row['type'] as int]));
  }

  @override
  Future<Routine?> get(int routineId) async {
    return _queryAdapter.query('SELECT * FROM routine WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Routine(
            id: row['id'] as int?,
            name: row['name'] as String,
            note: row['description'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            type: RoutineType.values[row['type'] as int]),
        arguments: [routineId]);
  }

  @override
  Future<List<Routine>> getByType(RoutineType type) async {
    return _queryAdapter.queryList(
        'SELECT * FROM routine WHERE type = ?1 ORDER BY timestamp DESC',
        mapper: (Map<String, Object?> row) => Routine(
            id: row['id'] as int?,
            name: row['name'] as String,
            note: row['description'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            type: RoutineType.values[row['type'] as int]),
        arguments: [type.index]);
  }

  @override
  Future<int?> getLargestSort() async {
    return _queryAdapter.query(
        'SELECT * FROM routine WHERE sort = (SELECT MAX(sort) FROM routine) AND type = 0',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> add(Routine routine) {
    return _routineInsertionAdapter.insertAndReturnId(
        routine, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(Routine routine) {
    return _routineUpdateAdapter.updateAndReturnChangedRows(
        routine, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Routine routine) {
    return _routineDeletionAdapter.deleteAndReturnChangedRows(routine);
  }
}

class _$SettingsDao extends SettingsDao {
  _$SettingsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _settingsInsertionAdapter = InsertionAdapter(
            database,
            'settings',
            (Settings item) => <String, Object?>{
                  'id': item.id,
                  'locale': _localeConverter.encode(item.locale),
                  'theme_id': item.themeId,
                  'unit': item.unit.index,
                  'session_weekly_goal': item.sessionWeeklyGoal,
                  'use_system_default_theme':
                      item.useSystemDefaultTheme ? 1 : 0,
                  'use_dynamic_color': item.useDynamicColor ? 1 : 0
                }),
        _settingsUpdateAdapter = UpdateAdapter(
            database,
            'settings',
            ['id'],
            (Settings item) => <String, Object?>{
                  'id': item.id,
                  'locale': _localeConverter.encode(item.locale),
                  'theme_id': item.themeId,
                  'unit': item.unit.index,
                  'session_weekly_goal': item.sessionWeeklyGoal,
                  'use_system_default_theme':
                      item.useSystemDefaultTheme ? 1 : 0,
                  'use_dynamic_color': item.useDynamicColor ? 1 : 0
                }),
        _settingsDeletionAdapter = DeletionAdapter(
            database,
            'settings',
            ['id'],
            (Settings item) => <String, Object?>{
                  'id': item.id,
                  'locale': _localeConverter.encode(item.locale),
                  'theme_id': item.themeId,
                  'unit': item.unit.index,
                  'session_weekly_goal': item.sessionWeeklyGoal,
                  'use_system_default_theme':
                      item.useSystemDefaultTheme ? 1 : 0,
                  'use_dynamic_color': item.useDynamicColor ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Settings> _settingsInsertionAdapter;

  final UpdateAdapter<Settings> _settingsUpdateAdapter;

  final DeletionAdapter<Settings> _settingsDeletionAdapter;

  @override
  Future<Settings?> get() async {
    return _queryAdapter.query('SELECT * FROM settings WHERE id = 1',
        mapper: (Map<String, Object?> row) => Settings(
            id: row['id'] as int,
            locale: _localeConverter.decode(row['locale'] as String),
            themeId: row['theme_id'] as int,
            unit: Unit.values[row['unit'] as int],
            sessionWeeklyGoal: row['session_weekly_goal'] as int,
            useSystemDefaultTheme:
                (row['use_system_default_theme'] as int) != 0,
            useDynamicColor: (row['use_dynamic_color'] as int) != 0));
  }

  @override
  Future<int> add(Settings settings) {
    return _settingsInsertionAdapter.insertAndReturnId(
        settings, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(Settings settings) {
    return _settingsUpdateAdapter.updateAndReturnChangedRows(
        settings, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Settings settings) {
    return _settingsDeletionAdapter.deleteAndReturnChangedRows(settings);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'data': item.data,
                  'exercise_group_id': item.exerciseGroupId
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'data': item.data,
                  'exercise_group_id': item.exerciseGroupId
                }),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'data': item.data,
                  'exercise_group_id': item.exerciseGroupId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Future<Note?> get(int noteId) async {
    return _queryAdapter.query('SELECT * FROM note WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            data: row['data'] as String,
            exerciseGroupId: row['exercise_group_id'] as int),
        arguments: [noteId]);
  }

  @override
  Future<List<Note>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM note',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            data: row['data'] as String,
            exerciseGroupId: row['exercise_group_id'] as int));
  }

  @override
  Future<List<Note>> getByExerciseGroupId(int exerciseGroupId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM note WHERE exercise_group_id = ?1',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            data: row['data'] as String,
            exerciseGroupId: row['exercise_group_id'] as int),
        arguments: [exerciseGroupId]);
  }

  @override
  Future<int> add(Note note) {
    return _noteInsertionAdapter.insertAndReturnId(
        note, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<Note> notes) {
    return _noteInsertionAdapter.insertListAndReturnIds(
        notes, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(Note note) {
    return _noteUpdateAdapter.updateAndReturnChangedRows(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Note note) {
    return _noteDeletionAdapter.deleteAndReturnChangedRows(note);
  }
}

class _$WorkoutDataDao extends WorkoutDataDao {
  _$WorkoutDataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _workoutDataInsertionAdapter = InsertionAdapter(
            database,
            'workout_data',
            (WorkoutData item) => <String, Object?>{
                  'id': item.id,
                  'is_active': item.isActive ? 1 : 0,
                  'time_elapsed': _timedConverter.encode(item.timeElapsed),
                  'routine_id': item.routineId
                }),
        _workoutDataUpdateAdapter = UpdateAdapter(
            database,
            'workout_data',
            ['id'],
            (WorkoutData item) => <String, Object?>{
                  'id': item.id,
                  'is_active': item.isActive ? 1 : 0,
                  'time_elapsed': _timedConverter.encode(item.timeElapsed),
                  'routine_id': item.routineId
                }),
        _workoutDataDeletionAdapter = DeletionAdapter(
            database,
            'workout_data',
            ['id'],
            (WorkoutData item) => <String, Object?>{
                  'id': item.id,
                  'is_active': item.isActive ? 1 : 0,
                  'time_elapsed': _timedConverter.encode(item.timeElapsed),
                  'routine_id': item.routineId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WorkoutData> _workoutDataInsertionAdapter;

  final UpdateAdapter<WorkoutData> _workoutDataUpdateAdapter;

  final DeletionAdapter<WorkoutData> _workoutDataDeletionAdapter;

  @override
  Future<WorkoutData?> get(int workoutDataId) async {
    return _queryAdapter.query('SELECT * FROM workout_data WHERE id = ?1',
        mapper: (Map<String, Object?> row) => WorkoutData(
            id: row['id'] as int?,
            isActive: (row['is_active'] as int) != 0,
            timeElapsed: _timedConverter.decode(row['time_elapsed'] as int),
            routineId: row['routine_id'] as int),
        arguments: [workoutDataId]);
  }

  @override
  Future<List<WorkoutData>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM workout_data',
        mapper: (Map<String, Object?> row) => WorkoutData(
            id: row['id'] as int?,
            isActive: (row['is_active'] as int) != 0,
            timeElapsed: _timedConverter.decode(row['time_elapsed'] as int),
            routineId: row['routine_id'] as int));
  }

  @override
  Future<List<WorkoutData>> getByRoutine(int routineId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM workout_data WHERE routine_id = ?1',
        mapper: (Map<String, Object?> row) => WorkoutData(
            id: row['id'] as int?,
            isActive: (row['is_active'] as int) != 0,
            timeElapsed: _timedConverter.decode(row['time_elapsed'] as int),
            routineId: row['routine_id'] as int),
        arguments: [routineId]);
  }

  @override
  Future<WorkoutData?> getByIsActive() async {
    return _queryAdapter.query('SELECT * FROM workout_data WHERE is_active = 1',
        mapper: (Map<String, Object?> row) => WorkoutData(
            id: row['id'] as int?,
            isActive: (row['is_active'] as int) != 0,
            timeElapsed: _timedConverter.decode(row['time_elapsed'] as int),
            routineId: row['routine_id'] as int));
  }

  @override
  Future<int> add(WorkoutData workoutData) {
    return _workoutDataInsertionAdapter.insertAndReturnId(
        workoutData, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> addAll(List<WorkoutData> workoutData) {
    return _workoutDataInsertionAdapter.insertListAndReturnIds(
        workoutData, OnConflictStrategy.abort);
  }

  @override
  Future<int> modify(WorkoutData workoutData) {
    return _workoutDataUpdateAdapter.updateAndReturnChangedRows(
        workoutData, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(WorkoutData workoutData) {
    return _workoutDataDeletionAdapter.deleteAndReturnChangedRows(workoutData);
  }
}

class _$SessionDataDao extends SessionDataDao {
  _$SessionDataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sessionDataInsertionAdapter = InsertionAdapter(
            database,
            'session_data',
            (SessionData item) => <String, Object?>{
                  'id': item.id,
                  'time_elapsed': _timedConverter.encode(item.timeElapsed),
                  'routine_id': item.routineId,
                  'import_id': item.importId
                }),
        _sessionDataUpdateAdapter = UpdateAdapter(
            database,
            'session_data',
            ['id'],
            (SessionData item) => <String, Object?>{
                  'id': item.id,
                  'time_elapsed': _timedConverter.encode(item.timeElapsed),
                  'routine_id': item.routineId,
                  'import_id': item.importId
                }),
        _sessionDataDeletionAdapter = DeletionAdapter(
            database,
            'session_data',
            ['id'],
            (SessionData item) => <String, Object?>{
                  'id': item.id,
                  'time_elapsed': _timedConverter.encode(item.timeElapsed),
                  'routine_id': item.routineId,
                  'import_id': item.importId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SessionData> _sessionDataInsertionAdapter;

  final UpdateAdapter<SessionData> _sessionDataUpdateAdapter;

  final DeletionAdapter<SessionData> _sessionDataDeletionAdapter;

  @override
  Future<SessionData?> get(int sessionDataId) async {
    return _queryAdapter.query('SELECT * FROM session_data WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SessionData(
            id: row['id'] as int?,
            timeElapsed: _timedConverter.decode(row['time_elapsed'] as int),
            routineId: row['routine_id'] as int,
            importId: row['import_id'] as int?),
        arguments: [sessionDataId]);
  }

  @override
  Future<List<SessionData>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM session_data',
        mapper: (Map<String, Object?> row) => SessionData(
            id: row['id'] as int?,
            timeElapsed: _timedConverter.decode(row['time_elapsed'] as int),
            routineId: row['routine_id'] as int,
            importId: row['import_id'] as int?));
  }

  @override
  Future<SessionData?> getByRoutineId(int routineId) async {
    return _queryAdapter.query(
        'SELECT * FROM session_data WHERE routine_id = ?1',
        mapper: (Map<String, Object?> row) => SessionData(
            id: row['id'] as int?,
            timeElapsed: _timedConverter.decode(row['time_elapsed'] as int),
            routineId: row['routine_id'] as int,
            importId: row['import_id'] as int?),
        arguments: [routineId]);
  }

  @override
  Future<int> add(SessionData workoutData) {
    return _sessionDataInsertionAdapter.insertAndReturnId(
        workoutData, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<SessionData> workoutData) {
    return _sessionDataInsertionAdapter.insertListAndReturnIds(
        workoutData, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(SessionData workoutData) {
    return _sessionDataUpdateAdapter.updateAndReturnChangedRows(
        workoutData, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(SessionData workoutData) {
    return _sessionDataDeletionAdapter.deleteAndReturnChangedRows(workoutData);
  }
}

class _$TemplateDataDao extends TemplateDataDao {
  _$TemplateDataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _templateDataInsertionAdapter = InsertionAdapter(
            database,
            'template_data',
            (TemplateData item) => <String, Object?>{
                  'id': item.id,
                  'sort': item.sort,
                  'routine_id': item.routineId
                }),
        _templateDataUpdateAdapter = UpdateAdapter(
            database,
            'template_data',
            ['id'],
            (TemplateData item) => <String, Object?>{
                  'id': item.id,
                  'sort': item.sort,
                  'routine_id': item.routineId
                }),
        _templateDataDeletionAdapter = DeletionAdapter(
            database,
            'template_data',
            ['id'],
            (TemplateData item) => <String, Object?>{
                  'id': item.id,
                  'sort': item.sort,
                  'routine_id': item.routineId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TemplateData> _templateDataInsertionAdapter;

  final UpdateAdapter<TemplateData> _templateDataUpdateAdapter;

  final DeletionAdapter<TemplateData> _templateDataDeletionAdapter;

  @override
  Future<TemplateData?> get(int templateDataId) async {
    return _queryAdapter.query('SELECT * FROM template_data WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TemplateData(
            id: row['id'] as int?,
            sort: row['sort'] as int,
            routineId: row['routine_id'] as int),
        arguments: [templateDataId]);
  }

  @override
  Future<List<TemplateData>> getAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM template_data ORDER BY sort ASC',
        mapper: (Map<String, Object?> row) => TemplateData(
            id: row['id'] as int?,
            sort: row['sort'] as int,
            routineId: row['routine_id'] as int));
  }

  @override
  Future<TemplateData?> getByRoutineId(int routineId) async {
    return _queryAdapter.query(
        'SELECT * FROM template_data WHERE routine_id = ?1',
        mapper: (Map<String, Object?> row) => TemplateData(
            id: row['id'] as int?,
            sort: row['sort'] as int,
            routineId: row['routine_id'] as int),
        arguments: [routineId]);
  }

  @override
  Future<int> add(TemplateData templateData) {
    return _templateDataInsertionAdapter.insertAndReturnId(
        templateData, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<TemplateData> templateData) {
    return _templateDataInsertionAdapter.insertListAndReturnIds(
        templateData, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(TemplateData templateData) {
    return _templateDataUpdateAdapter.updateAndReturnChangedRows(
        templateData, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(TemplateData templateData) {
    return _templateDataDeletionAdapter
        .deleteAndReturnChangedRows(templateData);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'description': item.description,
                  'gender': item.gender.index,
                  'height': item.height,
                  'age': item.age,
                  'created_at': _dateTimeConverter.encode(item.createdAt),
                  'picture': item.picture
                }),
        _userUpdateAdapter = UpdateAdapter(
            database,
            'user',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'description': item.description,
                  'gender': item.gender.index,
                  'height': item.height,
                  'age': item.age,
                  'created_at': _dateTimeConverter.encode(item.createdAt),
                  'picture': item.picture
                }),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'description': item.description,
                  'gender': item.gender.index,
                  'height': item.height,
                  'age': item.age,
                  'created_at': _dateTimeConverter.encode(item.createdAt),
                  'picture': item.picture
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<User> _userUpdateAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<User?> get(int id) async {
    return _queryAdapter.query('SELECT * FROM user WHERE id = ?1',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int,
            username: row['username'] as String,
            description: row['description'] as String,
            gender: Gender.values[row['gender'] as int],
            height: row['height'] as double,
            age: row['age'] as int,
            createdAt: _dateTimeConverter.decode(row['created_at'] as String),
            picture: row['picture'] as String),
        arguments: [id]);
  }

  @override
  Future<int> add(User user) {
    return _userInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(User user) {
    return _userUpdateAdapter.updateAndReturnChangedRows(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(User user) {
    return _userDeletionAdapter.deleteAndReturnChangedRows(user);
  }
}

class _$ImportDao extends ImportDao {
  _$ImportDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _importInsertionAdapter = InsertionAdapter(
            database,
            'import',
            (Import item) => <String, Object?>{
                  'id': item.id,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'transfer_source': item.source.index
                }),
        _importUpdateAdapter = UpdateAdapter(
            database,
            'import',
            ['id'],
            (Import item) => <String, Object?>{
                  'id': item.id,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'transfer_source': item.source.index
                }),
        _importDeletionAdapter = DeletionAdapter(
            database,
            'import',
            ['id'],
            (Import item) => <String, Object?>{
                  'id': item.id,
                  'timestamp': _dateTimeConverter.encode(item.timestamp),
                  'transfer_source': item.source.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Import> _importInsertionAdapter;

  final UpdateAdapter<Import> _importUpdateAdapter;

  final DeletionAdapter<Import> _importDeletionAdapter;

  @override
  Future<Import?> get(int importId) async {
    return _queryAdapter.query('SELECT * FROM import WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Import(
            id: row['id'] as int?,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            source: TransferSource.values[row['transfer_source'] as int]),
        arguments: [importId]);
  }

  @override
  Future<List<Import>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM import',
        mapper: (Map<String, Object?> row) => Import(
            id: row['id'] as int?,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as String),
            source: TransferSource.values[row['transfer_source'] as int]));
  }

  @override
  Future<int> add(Import import) {
    return _importInsertionAdapter.insertAndReturnId(
        import, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(Import import) {
    return _importUpdateAdapter.updateAndReturnChangedRows(
        import, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Import import) {
    return _importDeletionAdapter.deleteAndReturnChangedRows(import);
  }
}

class _$ExportDao extends ExportDao {
  _$ExportDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exportInsertionAdapter = InsertionAdapter(
            database,
            'export',
            (Export item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date)
                }),
        _exportUpdateAdapter = UpdateAdapter(
            database,
            'export',
            ['id'],
            (Export item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date)
                }),
        _exportDeletionAdapter = DeletionAdapter(
            database,
            'export',
            ['id'],
            (Export item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Export> _exportInsertionAdapter;

  final UpdateAdapter<Export> _exportUpdateAdapter;

  final DeletionAdapter<Export> _exportDeletionAdapter;

  @override
  Future<Export?> get(int exportId) async {
    return _queryAdapter.query('SELECT * FROM export WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Export(
            id: row['id'] as int?,
            date: _dateTimeConverter.decode(row['date'] as String)),
        arguments: [exportId]);
  }

  @override
  Future<List<Export>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM export',
        mapper: (Map<String, Object?> row) => Export(
            id: row['id'] as int?,
            date: _dateTimeConverter.decode(row['date'] as String)));
  }

  @override
  Future<int> add(Export export) {
    return _exportInsertionAdapter.insertAndReturnId(
        export, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(Export export) {
    return _exportUpdateAdapter.updateAndReturnChangedRows(
        export, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(Export export) {
    return _exportDeletionAdapter.deleteAndReturnChangedRows(export);
  }
}

class _$AppThemeDao extends AppThemeDao {
  _$AppThemeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _appThemeInsertionAdapter = InsertionAdapter(
            database,
            'app_theme',
            (AppTheme item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'brightness': item.brightness.index
                }),
        _appThemeUpdateAdapter = UpdateAdapter(
            database,
            'app_theme',
            ['id'],
            (AppTheme item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'brightness': item.brightness.index
                }),
        _appThemeDeletionAdapter = DeletionAdapter(
            database,
            'app_theme',
            ['id'],
            (AppTheme item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'brightness': item.brightness.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AppTheme> _appThemeInsertionAdapter;

  final UpdateAdapter<AppTheme> _appThemeUpdateAdapter;

  final DeletionAdapter<AppTheme> _appThemeDeletionAdapter;

  @override
  Future<AppTheme?> get(int appThemeId) async {
    return _queryAdapter.query('SELECT * FROM app_theme WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AppTheme(
            id: row['id'] as int?,
            name: row['name'] as String,
            brightness: Brightness.values[row['brightness'] as int]),
        arguments: [appThemeId]);
  }

  @override
  Future<List<AppTheme>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM app_theme',
        mapper: (Map<String, Object?> row) => AppTheme(
            id: row['id'] as int?,
            name: row['name'] as String,
            brightness: Brightness.values[row['brightness'] as int]));
  }

  @override
  Future<int> add(AppTheme appTheme) {
    return _appThemeInsertionAdapter.insertAndReturnId(
        appTheme, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<AppTheme> appThemes) {
    return _appThemeInsertionAdapter.insertListAndReturnIds(
        appThemes, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(AppTheme appTheme) {
    return _appThemeUpdateAdapter.updateAndReturnChangedRows(
        appTheme, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(AppTheme appTheme) {
    return _appThemeDeletionAdapter.deleteAndReturnChangedRows(appTheme);
  }
}

class _$AppThemeColorDao extends AppThemeColorDao {
  _$AppThemeColorDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _appThemeColorInsertionAdapter = InsertionAdapter(
            database,
            'app_theme_color',
            (AppThemeColor item) => <String, Object?>{
                  'id': item.id,
                  'app_theme_id': item.appThemeId,
                  'primary': _colorConverter.encode(item.primary),
                  'on_primary': _colorConverter.encode(item.onPrimary),
                  'primary_container':
                      _colorConverter.encode(item.primaryContainer),
                  'on_primary_container':
                      _colorConverter.encode(item.onPrimaryContainer),
                  'secondary': _colorConverter.encode(item.secondary),
                  'on_secondary': _colorConverter.encode(item.onSecondary),
                  'secondary_container':
                      _colorConverter.encode(item.secondaryContainer),
                  'on_secondary_container':
                      _colorConverter.encode(item.onSecondaryContainer),
                  'background': _colorConverter.encode(item.background),
                  'on_background': _colorConverter.encode(item.onBackground),
                  'surface': _colorConverter.encode(item.surface),
                  'on_surface': _colorConverter.encode(item.onSurface),
                  'on_surface_variant':
                      _colorConverter.encode(item.onSurfaceVariant),
                  'outline': _colorConverter.encode(item.outline),
                  'outline_variant':
                      _colorConverter.encode(item.outlineVariant),
                  'inverse_primary':
                      _colorConverter.encode(item.inversePrimary),
                  'inverse_surface':
                      _colorConverter.encode(item.inverseSurface),
                  'on_inverse_surface':
                      _colorConverter.encode(item.onInverseSurface),
                  'success': _colorConverter.encode(item.success),
                  'on_success': _colorConverter.encode(item.onSuccess),
                  'success_container':
                      _colorConverter.encode(item.successContainer),
                  'on_success_container':
                      _colorConverter.encode(item.onSuccessContainer),
                  'error': _colorConverter.encode(item.error),
                  'on_error': _colorConverter.encode(item.onError),
                  'error_container':
                      _colorConverter.encode(item.errorContainer),
                  'on_error_container':
                      _colorConverter.encode(item.onErrorContainer),
                  'shadow': _colorConverter.encode(item.shadow),
                  'warmup': _colorConverter.encode(item.warmup),
                  'drop': _colorConverter.encode(item.drop),
                  'cooldown': _colorConverter.encode(item.cooldown)
                }),
        _appThemeColorUpdateAdapter = UpdateAdapter(
            database,
            'app_theme_color',
            ['id'],
            (AppThemeColor item) => <String, Object?>{
                  'id': item.id,
                  'app_theme_id': item.appThemeId,
                  'primary': _colorConverter.encode(item.primary),
                  'on_primary': _colorConverter.encode(item.onPrimary),
                  'primary_container':
                      _colorConverter.encode(item.primaryContainer),
                  'on_primary_container':
                      _colorConverter.encode(item.onPrimaryContainer),
                  'secondary': _colorConverter.encode(item.secondary),
                  'on_secondary': _colorConverter.encode(item.onSecondary),
                  'secondary_container':
                      _colorConverter.encode(item.secondaryContainer),
                  'on_secondary_container':
                      _colorConverter.encode(item.onSecondaryContainer),
                  'background': _colorConverter.encode(item.background),
                  'on_background': _colorConverter.encode(item.onBackground),
                  'surface': _colorConverter.encode(item.surface),
                  'on_surface': _colorConverter.encode(item.onSurface),
                  'on_surface_variant':
                      _colorConverter.encode(item.onSurfaceVariant),
                  'outline': _colorConverter.encode(item.outline),
                  'outline_variant':
                      _colorConverter.encode(item.outlineVariant),
                  'inverse_primary':
                      _colorConverter.encode(item.inversePrimary),
                  'inverse_surface':
                      _colorConverter.encode(item.inverseSurface),
                  'on_inverse_surface':
                      _colorConverter.encode(item.onInverseSurface),
                  'success': _colorConverter.encode(item.success),
                  'on_success': _colorConverter.encode(item.onSuccess),
                  'success_container':
                      _colorConverter.encode(item.successContainer),
                  'on_success_container':
                      _colorConverter.encode(item.onSuccessContainer),
                  'error': _colorConverter.encode(item.error),
                  'on_error': _colorConverter.encode(item.onError),
                  'error_container':
                      _colorConverter.encode(item.errorContainer),
                  'on_error_container':
                      _colorConverter.encode(item.onErrorContainer),
                  'shadow': _colorConverter.encode(item.shadow),
                  'warmup': _colorConverter.encode(item.warmup),
                  'drop': _colorConverter.encode(item.drop),
                  'cooldown': _colorConverter.encode(item.cooldown)
                }),
        _appThemeColorDeletionAdapter = DeletionAdapter(
            database,
            'app_theme_color',
            ['id'],
            (AppThemeColor item) => <String, Object?>{
                  'id': item.id,
                  'app_theme_id': item.appThemeId,
                  'primary': _colorConverter.encode(item.primary),
                  'on_primary': _colorConverter.encode(item.onPrimary),
                  'primary_container':
                      _colorConverter.encode(item.primaryContainer),
                  'on_primary_container':
                      _colorConverter.encode(item.onPrimaryContainer),
                  'secondary': _colorConverter.encode(item.secondary),
                  'on_secondary': _colorConverter.encode(item.onSecondary),
                  'secondary_container':
                      _colorConverter.encode(item.secondaryContainer),
                  'on_secondary_container':
                      _colorConverter.encode(item.onSecondaryContainer),
                  'background': _colorConverter.encode(item.background),
                  'on_background': _colorConverter.encode(item.onBackground),
                  'surface': _colorConverter.encode(item.surface),
                  'on_surface': _colorConverter.encode(item.onSurface),
                  'on_surface_variant':
                      _colorConverter.encode(item.onSurfaceVariant),
                  'outline': _colorConverter.encode(item.outline),
                  'outline_variant':
                      _colorConverter.encode(item.outlineVariant),
                  'inverse_primary':
                      _colorConverter.encode(item.inversePrimary),
                  'inverse_surface':
                      _colorConverter.encode(item.inverseSurface),
                  'on_inverse_surface':
                      _colorConverter.encode(item.onInverseSurface),
                  'success': _colorConverter.encode(item.success),
                  'on_success': _colorConverter.encode(item.onSuccess),
                  'success_container':
                      _colorConverter.encode(item.successContainer),
                  'on_success_container':
                      _colorConverter.encode(item.onSuccessContainer),
                  'error': _colorConverter.encode(item.error),
                  'on_error': _colorConverter.encode(item.onError),
                  'error_container':
                      _colorConverter.encode(item.errorContainer),
                  'on_error_container':
                      _colorConverter.encode(item.onErrorContainer),
                  'shadow': _colorConverter.encode(item.shadow),
                  'warmup': _colorConverter.encode(item.warmup),
                  'drop': _colorConverter.encode(item.drop),
                  'cooldown': _colorConverter.encode(item.cooldown)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AppThemeColor> _appThemeColorInsertionAdapter;

  final UpdateAdapter<AppThemeColor> _appThemeColorUpdateAdapter;

  final DeletionAdapter<AppThemeColor> _appThemeColorDeletionAdapter;

  @override
  Future<AppThemeColor?> get(int appThemeColorId) async {
    return _queryAdapter.query('SELECT * FROM app_theme_color WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AppThemeColor(
            id: row['id'] as int?,
            appThemeId: row['app_theme_id'] as int,
            primary: _colorConverter.decode(row['primary'] as int),
            onPrimary: _colorConverter.decode(row['on_primary'] as int),
            primaryContainer:
                _colorConverter.decode(row['primary_container'] as int),
            onPrimaryContainer:
                _colorConverter.decode(row['on_primary_container'] as int),
            secondary: _colorConverter.decode(row['secondary'] as int),
            onSecondary: _colorConverter.decode(row['on_secondary'] as int),
            secondaryContainer:
                _colorConverter.decode(row['secondary_container'] as int),
            onSecondaryContainer:
                _colorConverter.decode(row['on_secondary_container'] as int),
            background: _colorConverter.decode(row['background'] as int),
            onBackground: _colorConverter.decode(row['on_background'] as int),
            surface: _colorConverter.decode(row['surface'] as int),
            onSurface: _colorConverter.decode(row['on_surface'] as int),
            onSurfaceVariant:
                _colorConverter.decode(row['on_surface_variant'] as int),
            outline: _colorConverter.decode(row['outline'] as int),
            outlineVariant:
                _colorConverter.decode(row['outline_variant'] as int),
            inversePrimary:
                _colorConverter.decode(row['inverse_primary'] as int),
            inverseSurface:
                _colorConverter.decode(row['inverse_surface'] as int),
            onInverseSurface:
                _colorConverter.decode(row['on_inverse_surface'] as int),
            success: _colorConverter.decode(row['success'] as int),
            onSuccess: _colorConverter.decode(row['on_success'] as int),
            successContainer:
                _colorConverter.decode(row['success_container'] as int),
            onSuccessContainer:
                _colorConverter.decode(row['on_success_container'] as int),
            error: _colorConverter.decode(row['error'] as int),
            onError: _colorConverter.decode(row['on_error'] as int),
            errorContainer:
                _colorConverter.decode(row['error_container'] as int),
            onErrorContainer:
                _colorConverter.decode(row['on_error_container'] as int),
            shadow: _colorConverter.decode(row['shadow'] as int),
            warmup: _colorConverter.decode(row['warmup'] as int),
            drop: _colorConverter.decode(row['drop'] as int),
            cooldown: _colorConverter.decode(row['cooldown'] as int)),
        arguments: [appThemeColorId]);
  }

  @override
  Future<List<AppThemeColor>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM app_theme_color',
        mapper: (Map<String, Object?> row) => AppThemeColor(
            id: row['id'] as int?,
            appThemeId: row['app_theme_id'] as int,
            primary: _colorConverter.decode(row['primary'] as int),
            onPrimary: _colorConverter.decode(row['on_primary'] as int),
            primaryContainer:
                _colorConverter.decode(row['primary_container'] as int),
            onPrimaryContainer:
                _colorConverter.decode(row['on_primary_container'] as int),
            secondary: _colorConverter.decode(row['secondary'] as int),
            onSecondary: _colorConverter.decode(row['on_secondary'] as int),
            secondaryContainer:
                _colorConverter.decode(row['secondary_container'] as int),
            onSecondaryContainer:
                _colorConverter.decode(row['on_secondary_container'] as int),
            background: _colorConverter.decode(row['background'] as int),
            onBackground: _colorConverter.decode(row['on_background'] as int),
            surface: _colorConverter.decode(row['surface'] as int),
            onSurface: _colorConverter.decode(row['on_surface'] as int),
            onSurfaceVariant:
                _colorConverter.decode(row['on_surface_variant'] as int),
            outline: _colorConverter.decode(row['outline'] as int),
            outlineVariant:
                _colorConverter.decode(row['outline_variant'] as int),
            inversePrimary:
                _colorConverter.decode(row['inverse_primary'] as int),
            inverseSurface:
                _colorConverter.decode(row['inverse_surface'] as int),
            onInverseSurface:
                _colorConverter.decode(row['on_inverse_surface'] as int),
            success: _colorConverter.decode(row['success'] as int),
            onSuccess: _colorConverter.decode(row['on_success'] as int),
            successContainer:
                _colorConverter.decode(row['success_container'] as int),
            onSuccessContainer:
                _colorConverter.decode(row['on_success_container'] as int),
            error: _colorConverter.decode(row['error'] as int),
            onError: _colorConverter.decode(row['on_error'] as int),
            errorContainer:
                _colorConverter.decode(row['error_container'] as int),
            onErrorContainer:
                _colorConverter.decode(row['on_error_container'] as int),
            shadow: _colorConverter.decode(row['shadow'] as int),
            warmup: _colorConverter.decode(row['warmup'] as int),
            drop: _colorConverter.decode(row['drop'] as int),
            cooldown: _colorConverter.decode(row['cooldown'] as int)));
  }

  @override
  Future<int> add(AppThemeColor appThemeColor) {
    return _appThemeColorInsertionAdapter.insertAndReturnId(
        appThemeColor, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> addAll(List<AppThemeColor> appThemeColors) {
    return _appThemeColorInsertionAdapter.insertListAndReturnIds(
        appThemeColors, OnConflictStrategy.replace);
  }

  @override
  Future<int> modify(AppThemeColor appThemeColor) {
    return _appThemeColorUpdateAdapter.updateAndReturnChangedRows(
        appThemeColor, OnConflictStrategy.abort);
  }

  @override
  Future<int> remove(AppThemeColor appThemeColor) {
    return _appThemeColorDeletionAdapter
        .deleteAndReturnChangedRows(appThemeColor);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _colorConverter = ColorConverter();
final _timedConverter = TimedConverter();
final _localeConverter = LocaleConverter();
final _setTypeConverter = SetTypeConverter();
final _durationConverter = DurationConverter();
