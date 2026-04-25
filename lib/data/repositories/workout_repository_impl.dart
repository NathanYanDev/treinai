import '../../domain/models/workout.dart';
import '../../domain/models/completed_workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../sources/api_data_source.dart';
import '../sources/local/completed_workout_local_data_source.dart';
import '../sources/local/workout_local_data_source.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl({
    required this.dataSource,
    WorkoutLocalDataSource? workoutLocalDataSource,
    CompletedWorkoutLocalDataSource? completedLocalDataSource,
  })  : _workoutLocalDataSource =
            workoutLocalDataSource ?? WorkoutLocalDataSource(),
        _completedLocalDataSource =
            completedLocalDataSource ?? CompletedWorkoutLocalDataSource();

  final ApiDataSource dataSource;
  final WorkoutLocalDataSource _workoutLocalDataSource;
  final CompletedWorkoutLocalDataSource _completedLocalDataSource;

  @override
  Future<List<Workout>> getWorkouts({String? userId}) async {
    try {
      final path = userId != null ? '/workouts?user_id=$userId' : '/workouts';
      final json = await dataSource.get(path) as List<dynamic>;
      final workouts = json
          .map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList();
      await _workoutLocalDataSource.replaceWorkouts(workouts, userId: userId);
      return workouts;
    } catch (_) {
      return _workoutLocalDataSource.getWorkouts(userId: userId);
    }
  }

  @override
  Future<Workout> getWorkoutById(String id) async {
    try {
      final json = await dataSource.get('/workouts/$id') as Map<String, dynamic>;
      final workout = Workout.fromJson(json);
      await _workoutLocalDataSource.replaceWorkouts([workout]);
      return workout;
    } catch (_) {
      final local = await _workoutLocalDataSource.getWorkoutById(id);
      if (local != null) return local;
      rethrow;
    }
  }

  @override
  Future<CompletedWorkout> saveCompletedWorkout(
      CompletedWorkout completed) async {
    try {
      final json = await dataSource.post(
        '/completed-workouts',
        completed.toJson(),
      ) as Map<String, dynamic>;
      final remote = CompletedWorkout.fromJson(json);
      await _completedLocalDataSource.saveCompletedWorkout(remote);
      return remote;
    } catch (_) {
      return _completedLocalDataSource.saveCompletedWorkout(completed);
    }
  }

  @override
  Future<List<CompletedWorkout>> getCompletedWorkouts(String userId) async {
    try {
      final json = await dataSource.get('/completed-workouts?user_id=$userId')
          as List<dynamic>;
      final completed = json
          .map((e) => CompletedWorkout.fromJson(e as Map<String, dynamic>))
          .toList();

      for (final item in completed) {
        await _completedLocalDataSource.saveCompletedWorkout(item);
      }

      return completed;
    } catch (_) {
      return _completedLocalDataSource.getCompletedWorkouts(userId);
    }
  }
}
