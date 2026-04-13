import 'workout_exercise.dart';

/// Treino exibido na lista, detalhe e execução (dados mock).
class WorkoutTemplate {
  const WorkoutTemplate({
    required this.id,
    required this.codeLabel,
    required this.muscleTitle,
    required this.exerciseCount,
    required this.durationMinutes,
    required this.sessionsHighlight,
    required this.scheduledWeekdays,
    required this.exercises,
  });

  final String id;
  final String codeLabel;
  final String muscleTitle;
  final int exerciseCount;
  final int durationMinutes;
  /// Texto do card resumo, ex.: "3x" para séries/semana no mock.
  final String sessionsHighlight;
  /// `DateTime.weekday`: 1 = segunda … 7 = domingo.
  final List<int> scheduledWeekdays;
  final List<WorkoutExercise> exercises;

  String get listTitle => '$codeLabel — $muscleTitle';
}
