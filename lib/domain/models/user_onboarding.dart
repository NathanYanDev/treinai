class UserOnboarding {
  const UserOnboarding({
    required this.userId,
    required this.goal,
    required this.location,
    required this.daysPerWeek,
    required this.durationMinutes,
    required this.level,
    required this.gender,
    required this.ageRange,
    required this.limitations,
    required this.muscularFocus,
  });

  final String userId;
  final String goal;
  final String location;
  final int daysPerWeek;
  final int durationMinutes;
  final String level;
  final String gender;
  final String ageRange;
  final List<String> limitations;
  final List<String> muscularFocus;

  factory UserOnboarding.fromJson(Map<String, dynamic> json) {
    return UserOnboarding(
      userId: json['user_id'] as String,
      goal: json['goal'] as String,
      location: json['location'] as String,
      daysPerWeek: json['days_per_week'] as int,
      durationMinutes: json['duration_minutes'] as int,
      level: json['level'] as String,
      gender: json['gender'] as String,
      ageRange: json['age_range'] as String,
      limitations: List<String>.from(json['limitations'] as List),
      muscularFocus: List<String>.from(json['muscular_focus'] as List),
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'goal': goal,
        'location': location,
        'days_per_week': daysPerWeek,
        'duration_minutes': durationMinutes,
        'level': level,
        'gender': gender,
        'age_range': ageRange,
        'limitations': limitations,
        'muscular_focus': muscularFocus,
      };
}
