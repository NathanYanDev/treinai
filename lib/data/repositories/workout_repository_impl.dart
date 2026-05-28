import '../../domain/models/workout.dart';
import '../../domain/models/completed_workout.dart';
import '../../domain/repositories/workout_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../sources/local/completed_workout_local_data_source.dart';
import '../sources/local/workout_local_data_source.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl({
    WorkoutLocalDataSource? workoutLocalDataSource,
    CompletedWorkoutLocalDataSource? completedLocalDataSource,
  })  : _workoutLocalDataSource =
            workoutLocalDataSource ?? WorkoutLocalDataSource(),
        _completedLocalDataSource =
            completedLocalDataSource ?? CompletedWorkoutLocalDataSource();

  final WorkoutLocalDataSource _workoutLocalDataSource;
  final CompletedWorkoutLocalDataSource _completedLocalDataSource;
  static final Map<String, List<Workout>> _webWorkoutsByUser = {};
  static final Map<String, List<CompletedWorkout>> _webCompletedByUser = {};

  String _resolveUserKey(String? userId) => userId ?? 'current_user';

  @override
  Future<List<Workout>> getWorkouts({String? userId}) async {
    if (kIsWeb) {
      final key = _resolveUserKey(userId);
      return List<Workout>.from(_webWorkoutsByUser[key] ?? const []);
    }
    return _workoutLocalDataSource.getWorkouts(userId: userId);
  }

  @override
  Future<Workout> getWorkoutById(String id) async {
    if (kIsWeb) {
      for (final workouts in _webWorkoutsByUser.values) {
        for (final workout in workouts) {
          if (workout.id == id) return workout;
        }
      }
      throw StateError('Treino não encontrado no cache local web: $id');
    }
    final local = await _workoutLocalDataSource.getWorkoutById(id);
    if (local != null) return local;
    throw StateError('Treino não encontrado no banco local: $id');
  }

  @override
  Future<List<Workout>> saveGeneratedWorkouts(
    List<Workout> workouts, {
    String? userId,
  }) async {
    if (kIsWeb) {
      final key = _resolveUserKey(userId);
      _webWorkoutsByUser[key] = List<Workout>.from(workouts);
      return workouts;
    }
    await _workoutLocalDataSource.replaceWorkouts(workouts, userId: userId);
    return workouts;
  }

  @override
  Future<CompletedWorkout> saveCompletedWorkout(
    CompletedWorkout completed,
  ) async {
    if (kIsWeb) {
      final key = _resolveUserKey(completed.userId);
      final saved = CompletedWorkout(
        id: completed.id ?? 'local_${DateTime.now().millisecondsSinceEpoch}',
        workoutId: completed.workoutId,
        userId: completed.userId,
        completedAt: completed.completedAt,
        durationMinutes: completed.durationMinutes,
        totalSets: completed.totalSets,
        totalReps: completed.totalReps,
      );
      final current = List<CompletedWorkout>.from(
        _webCompletedByUser[key] ?? const [],
      );
      current.add(saved);
      _webCompletedByUser[key] = current;
      return saved;
    }
    return _completedLocalDataSource.saveCompletedWorkout(completed);
  }

  @override
  Future<List<CompletedWorkout>> getCompletedWorkouts(String userId) async {
    if (kIsWeb) {
      final key = _resolveUserKey(userId);
      final current = List<CompletedWorkout>.from(
        _webCompletedByUser[key] ?? const [],
      );
      current.sort((a, b) => b.completedAt.compareTo(a.completedAt));
      return current;
    }
    return _completedLocalDataSource.getCompletedWorkouts(userId);
  }
}
