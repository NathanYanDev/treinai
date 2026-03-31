enum WorkoutDaysPerWeek {
  two(label: '2×', description: '2 dias por semana', promptKey: '2'),
  three(label: '3×', description: '3 dias por semana', promptKey: '3'),
  four(label: '4×', description: '4 dias por semana', promptKey: '4'),
  five(label: '5×', description: '5 dias por semana', promptKey: '5'),
  six(label: '6×', description: '6 dias por semana', promptKey: '6');

  const WorkoutDaysPerWeek({
    required this.label,
    required this.description,
    required this.promptKey,
  });

  final String label;
  final String description;
  final String promptKey;
}
