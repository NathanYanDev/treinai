import 'package:equatable/equatable.dart';
import '../../domain/models/workout.dart';
import '../../domain/models/completed_workout.dart';

enum WorkoutStatus { idle, loading, success, failure }

class WorkoutState extends Equatable {
  const WorkoutState({
    this.workouts = const [],
    this.completedWorkouts = const [],
    this.status = WorkoutStatus.idle,
    this.errorMessage,
  });

  final List<Workout> workouts;
  final List<CompletedWorkout> completedWorkouts;
  final WorkoutStatus status;
  final String? errorMessage;

  bool get isLoading => status == WorkoutStatus.loading;

  WorkoutState copyWith({
    List<Workout>? workouts,
    List<CompletedWorkout>? completedWorkouts,
    WorkoutStatus? status,
    String? errorMessage,
  }) {
    return WorkoutState(
      workouts: workouts ?? this.workouts,
      completedWorkouts: completedWorkouts ?? this.completedWorkouts,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [workouts, completedWorkouts, status, errorMessage];
}
