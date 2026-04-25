import '../../domain/models/workout.dart';
import '../../domain/models/completed_workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../sources/api_data_source.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl({required this.dataSource});

  final ApiDataSource dataSource;

  @override
  Future<List<Workout>> getWorkouts({String? userId}) async {
    final path = userId != null ? '/workouts?user_id=$userId' : '/workouts';
    final json = await dataSource.get(path) as List<dynamic>;
    return json
        .map((e) => Workout.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Workout> getWorkoutById(String id) async {
    final json = await dataSource.get('/workouts/$id') as Map<String, dynamic>;
    return Workout.fromJson(json);
  }

  @override
  Future<CompletedWorkout> saveCompletedWorkout(
      CompletedWorkout completed) async {
    final json = await dataSource.post(
      '/completed-workouts',
      completed.toJson(),
    ) as Map<String, dynamic>;
    return CompletedWorkout.fromJson(json);
  }

  @override
  Future<List<CompletedWorkout>> getCompletedWorkouts(String userId) async {
    final json = await dataSource.get('/completed-workouts?user_id=$userId')
        as List<dynamic>;
    return json
        .map((e) => CompletedWorkout.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
