import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const _databaseName = 'treinai.db';
  static const _databaseVersion = 2;

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
        await _ensureAuthSessionTable(db);
      },
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _createSchema(Database db) async {
    final batch = db.batch();

    batch.execute('''
      CREATE TABLE users (
        id         TEXT PRIMARY KEY,
        name       TEXT NOT NULL,
        email      TEXT NOT NULL UNIQUE,
        created_at INTEGER NOT NULL
      )
    ''');

    batch.execute('''
      CREATE TABLE onboarding_profiles (
        user_id          TEXT PRIMARY KEY,
        goal             TEXT NOT NULL,
        location         TEXT NOT NULL,
        days_per_week    INTEGER NOT NULL,
        duration_minutes INTEGER NOT NULL,
        level            TEXT NOT NULL,
        sex              TEXT NOT NULL,
        age_range        TEXT NOT NULL,
        limitations      TEXT NOT NULL DEFAULT '[]',
        muscular_focus   TEXT NOT NULL DEFAULT '[]',
        updated_at       INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

    batch.execute('''
      CREATE TABLE workouts (
        id         TEXT PRIMARY KEY,
        user_id    TEXT NOT NULL,
        name       TEXT NOT NULL,
        focus      TEXT,
        origin     TEXT NOT NULL DEFAULT 'ia',
        created_at INTEGER NOT NULL,
        is_synced  INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

    batch.execute('''
      CREATE TABLE exercises (
        id           TEXT PRIMARY KEY,
        name         TEXT NOT NULL,
        muscle_group TEXT NOT NULL,
        description  TEXT,
        instructions TEXT
      )
    ''');

    batch.execute('''
      CREATE TABLE workout_exercises (
        id          TEXT PRIMARY KEY,
        workout_id  TEXT NOT NULL,
        exercise_id TEXT NOT NULL,
        sets        INTEGER NOT NULL,
        reps        TEXT NOT NULL,
        rest_seconds INTEGER NOT NULL,
        order_index INTEGER NOT NULL,
        FOREIGN KEY (workout_id)  REFERENCES workouts(id)  ON DELETE CASCADE,
        FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE RESTRICT
      )
    ''');

    batch.execute('''
      CREATE TABLE exercise_logs (
        id                  TEXT PRIMARY KEY,
        workout_exercise_id TEXT NOT NULL,
        sets_completed      INTEGER NOT NULL DEFAULT 0,
        reps_completed      TEXT,
        status              TEXT NOT NULL DEFAULT 'completed',
        completed_at        INTEGER NOT NULL,
        FOREIGN KEY (workout_exercise_id)
          REFERENCES workout_exercises(id) ON DELETE CASCADE
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
      'CREATE INDEX idx_workout_exercises_workout_id ON workout_exercises(workout_id)',
    );
    batch.execute(
      'CREATE INDEX idx_exercise_logs_workout_exercise_id ON exercise_logs(workout_exercise_id)',
    );
    batch.execute(
      'CREATE INDEX idx_workouts_created_at ON workouts(created_at DESC)',
    );

    await batch.commit(noResult: true);
  }

  Future<void> _migrate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      final batch = db.batch();
      batch.execute('DROP TABLE IF EXISTS auth_session');
      batch.execute('DROP TABLE IF EXISTS completed_workouts');
      batch.execute('DROP TABLE IF EXISTS workouts');
      batch.execute('DROP TABLE IF EXISTS onboarding');
      await batch.commit(noResult: true);

      await _createSchema(db);
      return;
    }

    await _ensureAuthSessionTable(db);
  }

  Future<void> _ensureAuthSessionTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS auth_session (
        user_id TEXT PRIMARY KEY,
        jwt_token TEXT NOT NULL,
        token_type TEXT,
        expires_at TEXT,
        updated_at TEXT NOT NULL
      )
    ''');
  }
}
