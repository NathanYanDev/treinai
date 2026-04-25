import 'package:equatable/equatable.dart';

import '../../domain/models/workout_goal.dart';
import '../../domain/models/workout_location.dart';
import '../../domain/models/workout_days_per_week.dart';
import '../../domain/models/workout_duration.dart';
import '../../domain/models/workout_level.dart';
import '../../domain/models/biological_sex.dart';
import '../../domain/models/age_range.dart';
import '../../domain/models/physical_limitation.dart';
import '../../domain/models/muscular_focus.dart';

enum OnboardingStatus { idle, loading, success, failure }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.currentStep = 1,
    this.goal,
    this.location,
    this.daysPerWeek,
    this.minutesPerSession,
    this.level,
    this.gender,
    this.ageRange,
    this.limitations = const {},
    this.muscularFocus = const {},
    this.hasSubmitted = false,
    this.status = OnboardingStatus.idle,
    this.errorMessage,
  });

  final int currentStep;
  final WorkoutGoal? goal;
  final WorkoutLocation? location;
  final WorkoutDaysPerWeek? daysPerWeek;
  final WorkoutDuration? minutesPerSession;
  final WorkoutLevel? level;
  final BiologicalSex? gender;
  final AgeRange? ageRange;
  final Set<PhysicalLimitation> limitations;
  final Set<MuscularFocus> muscularFocus;
  final bool hasSubmitted;
  final OnboardingStatus status;
  final String? errorMessage;

  bool get canAdvance => goal != null;
  bool get isLoading => status == OnboardingStatus.loading;

  OnboardingState copyWith({
    int? currentStep,
    WorkoutGoal? goal,
    WorkoutLocation? location,
    WorkoutDaysPerWeek? daysPerWeek,
    WorkoutDuration? minutesPerSession,
    WorkoutLevel? level,
    BiologicalSex? gender,
    AgeRange? ageRange,
    Set<PhysicalLimitation>? limitations,
    Set<MuscularFocus>? muscularFocus,
    bool? hasSubmitted,
    OnboardingStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      goal: goal ?? this.goal,
      location: location ?? this.location,
      daysPerWeek: daysPerWeek ?? this.daysPerWeek,
      minutesPerSession: minutesPerSession ?? this.minutesPerSession,
      level: level ?? this.level,
      gender: gender ?? this.gender,
      ageRange: ageRange ?? this.ageRange,
      limitations: limitations ?? this.limitations,
      muscularFocus: muscularFocus ?? this.muscularFocus,
      hasSubmitted: hasSubmitted ?? this.hasSubmitted,
      status: status ?? this.status,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    goal,
    location,
    daysPerWeek,
    minutesPerSession,
    level,
    gender,
    ageRange,
    limitations,
    muscularFocus,
    hasSubmitted,
    status,
    errorMessage,
  ];
}
