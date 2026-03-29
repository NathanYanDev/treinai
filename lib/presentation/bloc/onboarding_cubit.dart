import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/workout_goal.dart';
import '../../domain/models/workout_location.dart';
import '../../domain/models/workout_days_per_week.dart';
import '../../domain/models/workout_duration.dart';
import '../../domain/models/workout_level.dart';
import '../../domain/models/biological_sex.dart';
import '../../domain/models/age_range.dart';
import '../../domain/models/physical_limitation.dart';
import '../../domain/models/muscular_focus.dart';

import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  static const int totalSteps = 9;

  void setGoal(WorkoutGoal goal) {
    emit(state.copyWith(goal: goal));
  }

  void setLocation(WorkoutLocation location) {
    emit(state.copyWith(location: location));
  }

  void setDaysPerWeek(WorkoutDaysPerWeek daysPerWeek) {
    emit(state.copyWith(daysPerWeek: daysPerWeek));
  }

  void setDuration(WorkoutDuration duration) {
    emit(state.copyWith(minutesPerSession: duration));
  }

  void setLevel(WorkoutLevel level) {
    emit(state.copyWith(level: level));
  }

  void setGender(BiologicalSex gender) {
    emit(state.copyWith(gender: gender));
  }

  void setAgeRange(AgeRange ageRange) {
    emit(state.copyWith(ageRange: ageRange));
  }

  void toggleLimitation(PhysicalLimitation limitation) {
    final current = Set<PhysicalLimitation>.from(state.limitations);

    if (limitation == PhysicalLimitation.none) {
      emit(state.copyWith(limitations: {PhysicalLimitation.none}));
      return;
    }

    current.remove(PhysicalLimitation.none);

    if (current.contains(limitation)) {
      current.remove(limitation);
    } else {
      current.add(limitation);
    }

    emit(state.copyWith(limitations: current));
  }

  void toggleMuscularFocus(MuscularFocus focus) {
    final current = Set<MuscularFocus>.from(state.muscularFocus);

    if (current.contains(focus)) {
      current.remove(focus);
    } else {
      current.add(focus);
    }

    emit(state.copyWith(muscularFocus: current));
  }

  void nextStep() {
    if (state.currentStep < totalSteps) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    } else {
      _submit();
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _submit() {
    // TODO: chamar o caso de uso de salvar o perfil
  }
}
