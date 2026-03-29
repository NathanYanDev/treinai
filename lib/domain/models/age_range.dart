enum AgeRange {
  under18(label: 'Menos de 18', promptKey: 'under_18'),
  range18to29(label: '18 – 29', promptKey: '18_29'),
  range30to39(label: '30 – 39', promptKey: '30_39'),
  range40to49(label: '40 – 49', promptKey: '40_49'),
  above50(label: '50 ou mais', promptKey: 'above_50');

  const AgeRange({required this.label, required this.promptKey});

  final String label;
  final String promptKey;
}
