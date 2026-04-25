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
import '../../domain/models/user_onboarding.dart';
import '../../domain/repositories/onboarding_repository.dart';

import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({OnboardingRepository? repository})
      : _repository = repository,
        super(const OnboardingState());

  final OnboardingRepository? _repository;

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

  Future<void> _submit() async {
    if (_repository == null) return;

    final s = state;
    if (s.goal == null ||
        s.location == null ||
        s.daysPerWeek == null ||
        s.minutesPerSession == null ||
        s.level == null ||
        s.gender == null ||
        s.ageRange == null) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Preencha todas as informações antes de continuar.',
      ));
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.loading));

    try {
      final onboarding = UserOnboarding(
        userId: 'current_user', // substituir pelo ID real após auth
        goal: s.goal!.promptKey,
        location: s.location!.promptKey,
        daysPerWeek: int.parse(s.daysPerWeek!.promptKey),
        durationMinutes: int.parse(s.minutesPerSession!.promptKey),
        level: s.level!.promptKey,
        gender: s.gender!.promptKey,
        ageRange: s.ageRange!.promptKey,
        limitations: s.limitations.map((l) => l.promptKey).toList(),
        muscularFocus: s.muscularFocus.map((f) => f.promptKey).toList(),
      );

      await _repository!.saveOnboarding(onboarding);
      emit(state.copyWith(status: OnboardingStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Não foi possível salvar o perfil. Tente novamente.',
      ));
    }
  }
}
