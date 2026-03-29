import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/workout_location.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingLocationPage extends StatelessWidget {
  const OnboardingLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 2,
          title: 'Qual é o seu local de treino',
          subtitle: 'Local e equipamentos disponíveis para o treino',
          options: WorkoutLocation.values
              .map(
                (location) => OnboardingOption(
                  emoji: location.emoji,
                  title: location.label,
                  subtitle: location.description,
                  isSelected: state.location == location,
                  onTap: () => cubit.setLocation(location),
                ),
              )
              .toList(),
          canAdvance: state.location != null,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
