import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/workout_duration.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingDurationPage extends StatelessWidget {
  const OnboardingDurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 4,
          title: 'Duração do treino',
          subtitle: 'Tempo em minutos do treino',
          options: WorkoutDuration.values
              .map(
                (duration) => OnboardingOption(
                  title: duration.label,
                  subtitle: duration.description,
                  isSelected: state.minutesPerSession == duration,
                  onTap: () => cubit.setDuration(duration),
                ),
              )
              .toList(),
          canAdvance: state.minutesPerSession != null,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
