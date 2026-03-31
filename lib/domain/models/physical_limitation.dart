enum PhysicalLimitation {
  none(
    label: 'Nenhuma',
    description: 'Sem restrições',
    emoji: '✅',
    promptKey: 'none',
  ),
  knee(
    label: 'Joelho',
    description: 'Dor ou lesão no joelho',
    emoji: '🦵',
    promptKey: 'knee',
  ),
  shoulder(
    label: 'Ombro',
    description: 'Dor ou lesão no ombro',
    emoji: '💪',
    promptKey: 'shoulder',
  ),
  spine(
    label: 'Coluna',
    description: 'Hérnia, lombalgia ou dor nas costas',
    emoji: '🦴',
    promptKey: 'spine',
  ),
  wrist(
    label: 'Punho',
    description: 'Dor ou lesão no punho',
    emoji: '🤝',
    promptKey: 'wrist',
  );

  const PhysicalLimitation({
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
