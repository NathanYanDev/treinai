import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/age_range.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingAgeRangePage extends StatelessWidget {
  const OnboardingAgeRangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 7,
          title: 'Faixa etária',
          subtitle: 'Selecione a faixa etária que melhor se descreve',
          options: AgeRange.values
              .map(
                (ageRange) => OnboardingOption(
                  title: ageRange.label,
                  isSelected: state.ageRange == ageRange,
                  onTap: () => cubit.setAgeRange(ageRange),
                ),
              )
              .toList(),
          canAdvance: state.ageRange != null,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
