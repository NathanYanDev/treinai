import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/workout_level.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingLevelPage extends StatelessWidget {
  const OnboardingLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 5,
          title: 'Nível de treinamento',
          subtitle: 'Selecione o seu nível de treinamento',
          options: WorkoutLevel.values
              .map(
                (level) => OnboardingOption(
                  title: level.label,
                  subtitle: level.description,
                  emoji: level.emoji,
                  isSelected: state.level == level,
                  onTap: () => cubit.setLevel(level),
                ),
              )
              .toList(),
          canAdvance: state.level != null,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
