import 'workout.dart';
import 'workout_exercise.dart';
import 'workout_template.dart';

extension WorkoutTemplateMapper on Workout {
  WorkoutTemplate toTemplate() {
    final exercisesMapped = exercises
        .map(
          (e) => WorkoutExercise(
            name: e.name,
            sets: e.sets,
            repsLabel: e.reps,
            restSeconds: e.restSeconds ?? 60,
            weightKg: 0,
          ),
        )
        .toList();

    final totalSets = exercisesMapped.fold<int>(0, (sum, e) => sum + e.sets);

    return WorkoutTemplate(
      id: id,
      codeLabel: name,
      muscleTitle: description,
      exerciseCount: exercisesMapped.length,
      durationMinutes: durationMinutes,
      sessionsHighlight: '${totalSets}x',
      scheduledWeekdays: const [1, 3, 5],
      exercises: exercisesMapped,
    );
  }
}
