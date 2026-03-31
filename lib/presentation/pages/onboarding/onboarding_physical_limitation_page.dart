import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/physical_limitation.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingPhysicalLimitationPage extends StatelessWidget {
  const OnboardingPhysicalLimitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 8,
          title: 'Qual o seu limite físico?',
          subtitle: 'Usamos isso para evitar exercícios contraindicados',
          options: PhysicalLimitation.values
              .map(
                (limitation) => OnboardingOption(
                  emoji: limitation.emoji,
                  title: limitation.label,
                  subtitle: limitation.description,
                  isSelected: state.limitations.contains(limitation),
                  onTap: () => cubit.toggleLimitation(limitation),
                ),
              )
              .toList(),
          canAdvance: state.limitations.isNotEmpty,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
