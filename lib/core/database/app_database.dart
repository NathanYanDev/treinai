import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const _databaseName = 'treinai.db';
  static const _databaseVersion = 3;

  Database? _db;

  Future<Database> get database async {
    _db ??= await _openDatabase();
    return _db!;
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }

  Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createSchema(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _migrate(db, oldVersion, newVersion);
      },
      onOpen: (db) async {
        await _ensureLocalTables(db);
      },
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _createSchema(Database db) async {
    final batch = db.batch();

    batch.execute('''
      CREATE TABLE onboarding (
        user_id          TEXT PRIMARY KEY,
        goal             TEXT NOT NULL,
        location         TEXT NOT NULL,
        days_per_week    INTEGER NOT NULL,
        duration_minutes INTEGER NOT NULL,
        level            TEXT NOT NULL,
        gender           TEXT NOT NULL,
        age_range        TEXT NOT NULL,
        limitations      TEXT NOT NULL DEFAULT '[]',
        muscular_focus   TEXT NOT NULL DEFAULT '[]',
        updated_at       TEXT NOT NULL
      )
    ''');

    batch.execute('''
      CREATE TABLE workouts (
        id         TEXT PRIMARY KEY,
        user_id    TEXT,
        name       TEXT NOT NULL,
        description TEXT NOT NULL,
        exercises_json TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    batch.execute('''
      CREATE TABLE completed_workouts (
        id TEXT PRIMARY KEY,
        workout_id TEXT NOT NULL,
        user_id TEXT NOT NULL,
        completed_at TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        total_sets INTEGER,
        total_reps INTEGER,
        is_synced INTEGER NOT NULL DEFAULT 0
      )
    ''');

    batch.execute('''
      CREATE TABLE auth_session (
        user_id TEXT PRIMARY KEY,
        jwt_token TEXT NOT NULL,
        token_type TEXT,
        expires_at TEXT,
        updated_at TEXT NOT NULL
      )
    ''');

    batch.execute('CREATE INDEX idx_workouts_user_id ON workouts(user_id)');
    batch.execute(
      'CREATE INDEX idx_workouts_created_at ON workouts(created_at DESC)',
    );
    batch.execute(
      'CREATE INDEX idx_completed_workouts_user_completed_at ON completed_workouts(user_id, completed_at DESC)',
    );

    await batch.commit(noResult: true);
  }

  Future<void> _migrate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      final batch = db.batch();
      batch.execute('DROP TABLE IF EXISTS completed_workouts');
      batch.execute('DROP TABLE IF EXISTS workouts');
      batch.execute('DROP TABLE IF EXISTS onboarding');
      batch.execute('DROP TABLE IF EXISTS onboarding_profiles');
      batch.execute('DROP TABLE IF EXISTS users');
      batch.execute('DROP TABLE IF EXISTS workout_exercises');
      batch.execute('DROP TABLE IF EXISTS exercises');
      batch.execute('DROP TABLE IF EXISTS exercise_logs');
      batch.execute('DROP TABLE IF EXISTS auth_session');
      await batch.commit(noResult: true);

      await _createSchema(db);
      return;
    }

    await _ensureLocalTables(db);
  }

  Future<void> _ensureLocalTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS onboarding (
        user_id          TEXT PRIMARY KEY,
        goal             TEXT NOT NULL,
        location         TEXT NOT NULL,
        days_per_week    INTEGER NOT NULL,
        duration_minutes INTEGER NOT NULL,
        level            TEXT NOT NULL,
        gender           TEXT NOT NULL,
        age_range        TEXT NOT NULL,
        limitations      TEXT NOT NULL DEFAULT '[]',
        muscular_focus   TEXT NOT NULL DEFAULT '[]',
        updated_at       TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS workouts (
        id         TEXT PRIMARY KEY,
        user_id    TEXT,
        name       TEXT NOT NULL,
        description TEXT NOT NULL,
        exercises_json TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS completed_workouts (
        id TEXT PRIMARY KEY,
        workout_id TEXT NOT NULL,
        user_id TEXT NOT NULL,
        completed_at TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        total_sets INTEGER,
        total_reps INTEGER,
        is_synced INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS auth_session (
        user_id TEXT PRIMARY KEY,
        jwt_token TEXT NOT NULL,
        token_type TEXT,
        expires_at TEXT,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_workouts_user_id ON workouts(user_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_workouts_created_at ON workouts(created_at DESC)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_completed_workouts_user_completed_at ON completed_workouts(user_id, completed_at DESC)',
    );
  }
}
