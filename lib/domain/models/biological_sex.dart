enum BiologicalSex {
  male(label: 'Masculino', emoji: '♂️', promptKey: 'male'),
  female(label: 'Feminino', emoji: '♀️', promptKey: 'female');

  const BiologicalSex({
    required this.label,
    required this.emoji,
    required this.promptKey,
  });

  final String label;
  final String emoji;
  final String promptKey;
}
