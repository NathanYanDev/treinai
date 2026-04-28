import 'package:sqflite/sqflite.dart';

import '../../../core/database/app_database.dart';
import '../../../domain/models/auth_session.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({AppDatabase? database})
      : _database = database ?? AppDatabase.instance;

  final AppDatabase _database;

  Future<void> saveSession(AuthSession session) async {
    final db = await _database.database;
    await db.delete('auth_session');
    await db.insert(
      'auth_session',
      {
        'user_id': session.userId,
        'jwt_token': session.token,
        'token_type': session.isFallbackToken ? 'fallback' : 'bearer',
        'updated_at': session.updatedAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<AuthSession?> getSession() async {
    try {
      final db = await _database.database;
      final rows = await db.query('auth_session', limit: 1);
      if (rows.isEmpty) return null;

      final row = rows.first;
      final userId = row['user_id'] as String;
      final token = row['jwt_token'] as String;
      final type = row['token_type'] as String?;
      final updatedAt = DateTime.parse(row['updated_at'] as String);

      return AuthSession(
        userId: userId,
        email: userId,
        token: token,
        isFallbackToken: type == 'fallback',
        updatedAt: updatedAt,
      );
    } on DatabaseException {
      // Protege o splash em aparelhos com schema antigo/incompleto.
      return null;
    }
  }

  Future<void> clearSession() async {
    final db = await _database.database;
    await db.delete('auth_session');
  }
}
