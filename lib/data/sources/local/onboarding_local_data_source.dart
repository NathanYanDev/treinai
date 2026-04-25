import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../../core/database/app_database.dart';
import '../../../domain/models/user_onboarding.dart';

class OnboardingLocalDataSource {
  OnboardingLocalDataSource({AppDatabase? database})
      : _database = database ?? AppDatabase.instance;

  final AppDatabase _database;

  Future<UserOnboarding?> getOnboarding(String userId) async {
    final db = await _database.database;
    final rows = await db.query(
      'onboarding',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return _mapRow(rows.first);
  }

  Future<UserOnboarding> saveOnboarding(UserOnboarding onboarding) async {
    final db = await _database.database;

    await db.insert(
      'onboarding',
      {
        'user_id': onboarding.userId,
        'goal': onboarding.goal,
        'location': onboarding.location,
        'days_per_week': onboarding.daysPerWeek,
        'duration_minutes': onboarding.durationMinutes,
        'level': onboarding.level,
        'gender': onboarding.gender,
        'age_range': onboarding.ageRange,
        'limitations': jsonEncode(onboarding.limitations),
        'muscular_focus': jsonEncode(onboarding.muscularFocus),
        'updated_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return onboarding;
  }

  UserOnboarding _mapRow(Map<String, Object?> row) {
    return UserOnboarding(
      userId: row['user_id'] as String,
      goal: row['goal'] as String,
      location: row['location'] as String,
      daysPerWeek: row['days_per_week'] as int,
      durationMinutes: row['duration_minutes'] as int,
      level: row['level'] as String,
      gender: row['gender'] as String,
      ageRange: row['age_range'] as String,
      limitations:
          List<String>.from(jsonDecode(row['limitations'] as String) as List),
      muscularFocus:
          List<String>.from(jsonDecode(row['muscular_focus'] as String) as List),
    );
  }
}
