import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/completed_workout.dart';
import '../../domain/repositories/workout_repository.dart';
import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit({required WorkoutRepository repository})
      : _repository = repository,
        super(const WorkoutState());

  final WorkoutRepository _repository;

  Future<void> loadWorkouts({String? userId}) async {
    emit(state.copyWith(status: WorkoutStatus.loading));
    try {
      final workouts = await _repository.getWorkouts(userId: userId);
      emit(state.copyWith(
        workouts: workouts,
        status: WorkoutStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WorkoutStatus.failure,
        errorMessage: 'Não foi possível carregar os treinos.',
      ));
    }
  }

  Future<void> loadCompletedWorkouts(String userId) async {
    emit(state.copyWith(status: WorkoutStatus.loading));
    try {
      final completed = await _repository.getCompletedWorkouts(userId);
      emit(state.copyWith(
        completedWorkouts: completed,
        status: WorkoutStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WorkoutStatus.failure,
        errorMessage: 'Não foi possível carregar o histórico.',
      ));
    }
  }

  Future<void> saveCompletedWorkout(CompletedWorkout completed) async {
    emit(state.copyWith(status: WorkoutStatus.loading));
    try {
      final saved = await _repository.saveCompletedWorkout(completed);
      emit(state.copyWith(
        completedWorkouts: [...state.completedWorkouts, saved],
        status: WorkoutStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WorkoutStatus.failure,
        errorMessage: 'Não foi possível salvar o treino.',
      ));
    }
  }
}
