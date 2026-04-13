class WorkoutExercise {
  const WorkoutExercise({
    required this.name,
    required this.sets,
    required this.repsLabel,
    required this.restSeconds,
    required this.weightKg,
  });

  final String name;
  final int sets;
  final String repsLabel;
  final int restSeconds;
  final int weightKg;
}
