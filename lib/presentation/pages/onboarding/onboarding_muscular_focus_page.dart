import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/muscular_focus.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingMuscularFocusPage extends StatelessWidget {
  const OnboardingMuscularFocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 9,
          title: 'Qual o seu foco muscular?',
          subtitle:
              'Escolha os principais grupos musculares que você pretende trabalhar',
          options: MuscularFocus.values
              .map(
                (muscular) => OnboardingOption(
                  emoji: muscular.emoji,
                  title: muscular.label,
                  isSelected: state.muscularFocus.contains(muscular),
                  onTap: () => cubit.toggleMuscularFocus(muscular),
                ),
              )
              .toList(),
          canAdvance: state.muscularFocus.isNotEmpty,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
