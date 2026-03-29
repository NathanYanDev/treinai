enum WorkoutLevel {
  beginner(
    label: 'Iniciante',
    description: 'Nunca treinou ou menos de 6 meses',
    emoji: '🌱',
    promptKey: 'beginner',
  ),
  intermediate(
    label: 'Intermediário',
    description: 'Entre 6 meses e 2 anos de treino',
    emoji: '📈',
    promptKey: 'intermediate',
  ),
  advanced(
    label: 'Avançado',
    description: 'Mais de 2 anos treinando',
    emoji: '🏆',
    promptKey: 'advanced',
  );

  const WorkoutLevel({
    required this.label,
    required this.description,
    required this.emoji,
    required this.promptKey,
  });

  final String label;
  final String description;
  final String emoji;
  final String promptKey;
}
