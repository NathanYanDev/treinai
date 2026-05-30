import '../models/workout.dart';
import '../models/completed_workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getWorkouts({String? userId});
  Future<Workout> getWorkoutById(String id);
  Future<List<Workout>> saveGeneratedWorkouts(
    List<Workout> workouts, {
    String? userId,
  });
  Future<CompletedWorkout> saveCompletedWorkout(CompletedWorkout completed);
  Future<List<CompletedWorkout>> getCompletedWorkouts(String userId);
}
