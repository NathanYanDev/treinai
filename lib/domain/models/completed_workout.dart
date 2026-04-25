class CompletedWorkout {
  const CompletedWorkout({
    this.id,
    required this.workoutId,
    required this.userId,
    required this.completedAt,
    required this.durationMinutes,
    this.totalSets,
    this.totalReps,
  });

  final String? id;
  final String workoutId;
  final String userId;
  final DateTime completedAt;
  final int durationMinutes;
  final int? totalSets;
  final int? totalReps;

  factory CompletedWorkout.fromJson(Map<String, dynamic> json) {
    return CompletedWorkout(
      id: json['id'] as String?,
      workoutId: json['workout_id'] as String,
      userId: json['user_id'] as String,
      completedAt: DateTime.parse(json['completed_at'] as String),
      durationMinutes: json['duration_minutes'] as int,
      totalSets: json['total_sets'] as int?,
      totalReps: json['total_reps'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'workout_id': workoutId,
        'user_id': userId,
        'completed_at': completedAt.toIso8601String(),
        'duration_minutes': durationMinutes,
        if (totalSets != null) 'total_sets': totalSets,
        if (totalReps != null) 'total_reps': totalReps,
      };
}
