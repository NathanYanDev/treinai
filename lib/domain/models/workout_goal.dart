enum WorkoutGoal {
  gainMuscle(
    label: 'Ganhar massa muscular',
    description: 'Hipertrofia e força muscular',
    emoji: '💪',
    promptKey: 'gain_muscle',
  ),
  loseFat(
    label: 'Emagrecer',
    description: 'Queima de gordura e definição',
    emoji: '🔥',
    promptKey: 'fat_loss',
  ),
  improveConditioning(
    label: 'Melhorar condicionamento',
    description: 'Resistência e saúde geral',
    emoji: '⚡',
    promptKey: 'improve_conditioning',
  ),
  maintainFitness(
    label: 'Manter forma',
    description: 'Equilíbrio e qualidade de vida',
    emoji: '🧘',
    promptKey: 'maintain_fitness',
  );

  const WorkoutGoal({
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
