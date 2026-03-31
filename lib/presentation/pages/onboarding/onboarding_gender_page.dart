import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/biological_sex.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingGenderPage extends StatelessWidget {
  const OnboardingGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 6,
          title: 'Sexo',
          subtitle: 'Selecione o seu sexo',
          options: BiologicalSex.values
              .map(
                (gender) => OnboardingOption(
                  title: gender.label,
                  emoji: gender.emoji,
                  isSelected: state.gender == gender,
                  onTap: () => cubit.setGender(gender),
                ),
              )
              .toList(),
          canAdvance: state.gender != null,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
