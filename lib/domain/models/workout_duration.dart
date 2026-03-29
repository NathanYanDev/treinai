enum WorkoutDuration {
  thirtyMin(
    label: '30 min',
    description: 'Treino rápido e objetivo',
    promptKey: '30',
  ),
  fortyFiveMin(
    label: '45 min',
    description: 'Equilibrado e eficiente',
    promptKey: '45',
  ),
  sixtyMin(label: '60 min', description: 'Treino completo', promptKey: '60'),
  ninetyMin(
    label: '90 min',
    description: 'Alto volume e intensidade',
    promptKey: '90',
  );

  const WorkoutDuration({
    required this.label,
    required this.description,
    required this.promptKey,
  });

  final String label;
  final String description;
  final String promptKey;
}
