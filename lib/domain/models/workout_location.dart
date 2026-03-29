enum WorkoutLocation {
  fullGym(
    label: 'Academia completa',
    description: 'Acesso a máquinas, cabos e pesos livres',
    emoji: '🏋️',
    promptKey: 'full_gym',
  ),
  basicGym(
    label: 'Academia simples',
    description: 'Pesos livres, sem máquinas',
    emoji: '🥊',
    promptKey: 'basic_gym',
  ),
  homeWithEquipment(
    label: 'Em casa com equipamentos',
    description: 'Halteres, elásticos ou barra',
    emoji: '🏠',
    promptKey: 'home_equipped',
  ),
  homeNoEquipment(
    label: 'Em casa sem equipamentos',
    description: 'Apenas o peso do corpo',
    emoji: '🤸',
    promptKey: 'home_bodyweight',
  );

  const WorkoutLocation({
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
