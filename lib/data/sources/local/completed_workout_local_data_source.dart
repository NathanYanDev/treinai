import 'package:sqflite/sqflite.dart';

import '../../../core/database/app_database.dart';
import '../../../domain/models/completed_workout.dart';

class CompletedWorkoutLocalDataSource {
  CompletedWorkoutLocalDataSource({AppDatabase? database})
      : _database = database ?? AppDatabase.instance;

  final AppDatabase _database;

  Future<CompletedWorkout> saveCompletedWorkout(CompletedWorkout completed) async {
    final db = await _database.database;
    final id = completed.id ?? 'local_${DateTime.now().millisecondsSinceEpoch}';

    await db.insert(
      'completed_workouts',
      {
        'id': id,
        'workout_id': completed.workoutId,
        'user_id': completed.userId,
        'completed_at': completed.completedAt.toIso8601String(),
        'duration_minutes': completed.durationMinutes,
        'total_sets': completed.totalSets,
        'total_reps': completed.totalReps,
        'is_synced': completed.id == null ? 0 : 1,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return CompletedWorkout(
      id: id,
      workoutId: completed.workoutId,
      userId: completed.userId,
      completedAt: completed.completedAt,
      durationMinutes: completed.durationMinutes,
      totalSets: completed.totalSets,
      totalReps: completed.totalReps,
    );
  }

  Future<List<CompletedWorkout>> getCompletedWorkouts(String userId) async {
    final db = await _database.database;
    final rows = await db.query(
      'completed_workouts',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'completed_at DESC',
    );

    return rows.map(_mapRow).toList();
  }

  CompletedWorkout _mapRow(Map<String, Object?> row) {
    return CompletedWorkout(
      id: row['id'] as String?,
      workoutId: row['workout_id'] as String,
      userId: row['user_id'] as String,
      completedAt: DateTime.parse(row['completed_at'] as String),
      durationMinutes: row['duration_minutes'] as int,
      totalSets: row['total_sets'] as int?,
      totalReps: row['total_reps'] as int?,
    );
  }
}
