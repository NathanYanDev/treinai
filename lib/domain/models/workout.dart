class Exercise {
  const Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.restSeconds,
    this.notes,
  });

  final String name;
  final int sets;
  final String reps;
  final int? restSeconds;
  final String? notes;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as String,
      restSeconds: json['rest_seconds'] as int?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'sets': sets,
        'reps': reps,
        if (restSeconds != null) 'rest_seconds': restSeconds,
        if (notes != null) 'notes': notes,
      };
}

class Workout {
  const Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.durationMinutes,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;
  final int durationMinutes;
  final DateTime createdAt;

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      durationMinutes: json['duration_minutes'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'exercises': exercises.map((e) => e.toJson()).toList(),
        'duration_minutes': durationMinutes,
        'created_at': createdAt.toIso8601String(),
      };
}
