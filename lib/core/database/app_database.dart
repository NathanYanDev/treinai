import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const _databaseName = 'treinai.db';
  static const _databaseVersion = 1;

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _openDatabase();
    return _db!;
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) return;
    await db.close();
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
    );
  }

  Future<void> _createSchema(Database db) async {
    await db.execute('''
      CREATE TABLE onboarding (
        user_id TEXT PRIMARY KEY,
        goal TEXT NOT NULL,
        location TEXT NOT NULL,
        days_per_week INTEGER NOT NULL,
        duration_minutes INTEGER NOT NULL,
        level TEXT NOT NULL,
        gender TEXT NOT NULL,
        age_range TEXT NOT NULL,
        limitations TEXT NOT NULL,
        muscular_focus TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE workouts (
        id TEXT PRIMARY KEY,
        user_id TEXT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        exercises_json TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
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

    await db.execute('''
      CREATE TABLE auth_session (
        user_id TEXT PRIMARY KEY,
        jwt_token TEXT NOT NULL,
        token_type TEXT,
        expires_at TEXT,
        updated_at TEXT NOT NULL
      )
    ''');
  }
}
