class WorkoutCompleteArgs {
  const WorkoutCompleteArgs({
    required this.workoutLabel,
    required this.completedExercises,
    required this.totalExercises,
    required this.durationMinutes,
    required this.totalSets,
    required this.totalReps,
    required this.streakDays,
    this.isNewRecord = true,
  });

  final String workoutLabel;
  final int completedExercises;
  final int totalExercises;
  final int durationMinutes;
  final int totalSets;
  final int totalReps;
  final int streakDays;
  final bool isNewRecord;

  static WorkoutCompleteArgs defaults() => const WorkoutCompleteArgs(
    workoutLabel: 'Treino A',
    completedExercises: 8,
    totalExercises: 8,
    durationMinutes: 52,
    totalSets: 24,
    totalReps: 288,
    streakDays: 8,
    isNewRecord: true,
  );
}
