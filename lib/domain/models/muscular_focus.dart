enum MuscularFocus {
  chest(label: 'Peito', emoji: '🫁', promptKey: 'chest'),
  back(label: 'Costas', emoji: '🔙', promptKey: 'back'),
  legs(label: 'Pernas', emoji: '🦵', promptKey: 'legs'),
  shoulders(label: 'Ombros', emoji: '🏋️', promptKey: 'shoulders'),
  arms(label: 'Braços', emoji: '💪', promptKey: 'arms'),
  core(label: 'Abdômen', emoji: '🎯', promptKey: 'core'),
  glutes(label: 'Glúteos', emoji: '🍑', promptKey: 'glutes');

  const MuscularFocus({
    required this.label,
    required this.emoji,
    required this.promptKey,
  });

  final String label;
  final String emoji;
  final String promptKey;
}
