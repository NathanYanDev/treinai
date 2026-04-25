import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../../core/database/app_database.dart';
import '../../../domain/models/workout.dart';

class WorkoutLocalDataSource {
  WorkoutLocalDataSource({AppDatabase? database})
      : _database = database ?? AppDatabase.instance;

  final AppDatabase _database;

  Future<void> replaceWorkouts(List<Workout> workouts, {String? userId}) async {
    final db = await _database.database;
    final now = DateTime.now().toIso8601String();

    await db.transaction((txn) async {
      if (userId != null) {
        await txn.delete('workouts', where: 'user_id = ?', whereArgs: [userId]);
      }

      for (final workout in workouts) {
        await txn.insert(
          'workouts',
          {
            'id': workout.id,
            'user_id': userId,
            'name': workout.name,
            'description': workout.description,
            'exercises_json':
                jsonEncode(workout.exercises.map((e) => e.toJson()).toList()),
            'duration_minutes': workout.durationMinutes,
            'created_at': workout.createdAt.toIso8601String(),
            'updated_at': now,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Workout>> getWorkouts({String? userId}) async {
    final db = await _database.database;
    final rows = await db.query(
      'workouts',
      where: userId != null ? 'user_id = ?' : null,
      whereArgs: userId != null ? [userId] : null,
      orderBy: 'created_at DESC',
    );

    return rows.map(_mapRow).toList();
  }

  Future<Workout?> getWorkoutById(String id) async {
    final db = await _database.database;
    final rows = await db.query(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return _mapRow(rows.first);
  }

  Workout _mapRow(Map<String, Object?> row) {
    final exercisesJson = jsonDecode(row['exercises_json'] as String) as List;

    return Workout(
      id: row['id'] as String,
      name: row['name'] as String,
      description: row['description'] as String,
      exercises: exercisesJson
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      durationMinutes: row['duration_minutes'] as int,
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }
}
