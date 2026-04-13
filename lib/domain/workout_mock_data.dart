import 'models/workout_exercise.dart';
import 'models/workout_template.dart';

abstract final class WorkoutMockData {
  static final List<WorkoutTemplate> templates = [
    WorkoutTemplate(
      id: 'a',
      codeLabel: 'Treino A',
      muscleTitle: 'Peito e Tríceps',
      exerciseCount: 8,
      durationMinutes: 55,
      sessionsHighlight: '3x',
      scheduledWeekdays: [1, 3, 5],
      exercises: _treinoAExercises,
    ),
    WorkoutTemplate(
      id: 'b',
      codeLabel: 'Treino B',
      muscleTitle: 'Costas e Bíceps',
      exerciseCount: 7,
      durationMinutes: 50,
      sessionsHighlight: '3x',
      scheduledWeekdays: [2, 4],
      exercises: _treinoBExercises,
    ),
    WorkoutTemplate(
      id: 'c',
      codeLabel: 'Treino C',
      muscleTitle: 'Pernas',
      exerciseCount: 6,
      durationMinutes: 60,
      sessionsHighlight: '2x',
      scheduledWeekdays: [3, 5],
      exercises: _treinoCExercises,
    ),
  ];

  static WorkoutTemplate? byId(String id) {
    for (final t in templates) {
      if (t.id == id) return t;
    }
    return null;
  }

  static const List<WorkoutExercise> _treinoAExercises = [
    WorkoutExercise(
      name: 'Supino Reto',
      sets: 4,
      repsLabel: '8-12',
      restSeconds: 90,
      weightKg: 15,
    ),
    WorkoutExercise(
      name: 'Supino Inclinado',
      sets: 3,
      repsLabel: '10-12',
      restSeconds: 75,
      weightKg: 12,
    ),
    WorkoutExercise(
      name: 'Crossover',
      sets: 4,
      repsLabel: '12-15',
      restSeconds: 60,
      weightKg: 10,
    ),
    WorkoutExercise(
      name: 'Tríceps Pulley',
      sets: 4,
      repsLabel: '10-12',
      restSeconds: 60,
      weightKg: 20,
    ),
    WorkoutExercise(
      name: 'Supino com halteres',
      sets: 3,
      repsLabel: '8-10',
      restSeconds: 90,
      weightKg: 14,
    ),
    WorkoutExercise(
      name: 'Crucifixo',
      sets: 3,
      repsLabel: '12-15',
      restSeconds: 45,
      weightKg: 8,
    ),
    WorkoutExercise(
      name: 'Tríceps testa',
      sets: 3,
      repsLabel: '10-12',
      restSeconds: 60,
      weightKg: 12,
    ),
    WorkoutExercise(
      name: 'Mergulho na paralela',
      sets: 3,
      repsLabel: 'até a falha',
      restSeconds: 90,
      weightKg: 0,
    ),
  ];

  static const List<WorkoutExercise> _treinoBExercises = [
    WorkoutExercise(
      name: 'Barra fixa',
      sets: 4,
      repsLabel: '6-10',
      restSeconds: 120,
      weightKg: 0,
    ),
    WorkoutExercise(
      name: 'Remada curvada',
      sets: 4,
      repsLabel: '8-10',
      restSeconds: 90,
      weightKg: 40,
    ),
    WorkoutExercise(
      name: 'Puxada frontal',
      sets: 3,
      repsLabel: '10-12',
      restSeconds: 75,
      weightKg: 35,
    ),
    WorkoutExercise(
      name: 'Rosca direta',
      sets: 3,
      repsLabel: '10-12',
      restSeconds: 60,
      weightKg: 12,
    ),
    WorkoutExercise(
      name: 'Remada unilateral',
      sets: 3,
      repsLabel: '10-12',
      restSeconds: 60,
      weightKg: 18,
    ),
    WorkoutExercise(
      name: 'Rosca martelo',
      sets: 3,
      repsLabel: '12-15',
      restSeconds: 45,
      weightKg: 10,
    ),
    WorkoutExercise(
      name: 'Face pull',
      sets: 3,
      repsLabel: '15-20',
      restSeconds: 45,
      weightKg: 15,
    ),
  ];

  static const List<WorkoutExercise> _treinoCExercises = [
    WorkoutExercise(
      name: 'Agachamento livre',
      sets: 4,
      repsLabel: '8-10',
      restSeconds: 120,
      weightKg: 60,
    ),
    WorkoutExercise(
      name: 'Leg press',
      sets: 4,
      repsLabel: '12-15',
      restSeconds: 90,
      weightKg: 120,
    ),
    WorkoutExercise(
      name: 'Cadeira extensora',
      sets: 3,
      repsLabel: '12-15',
      restSeconds: 60,
      weightKg: 35,
    ),
    WorkoutExercise(
      name: 'Stiff',
      sets: 3,
      repsLabel: '10-12',
      restSeconds: 90,
      weightKg: 40,
    ),
    WorkoutExercise(
      name: 'Cadeira flexora',
      sets: 3,
      repsLabel: '12-15',
      restSeconds: 60,
      weightKg: 30,
    ),
    WorkoutExercise(
      name: 'Panturrilha em pé',
      sets: 4,
      repsLabel: '15-20',
      restSeconds: 45,
      weightKg: 50,
    ),
  ];
}
