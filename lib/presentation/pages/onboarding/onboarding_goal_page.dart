import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/workout_goal.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingGoalPage extends StatelessWidget {
  const OnboardingGoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 1,
          title: 'Qual é o seu objetivo?',
          subtitle: 'Isso define a base do seu treino personalizado.',
          options: WorkoutGoal.values
              .map(
                (goal) => OnboardingOption(
                  emoji: goal.emoji,
                  title: goal.label,
                  subtitle: goal.description,
                  isSelected: state.goal == goal,
                  onTap: () => cubit.setGoal(goal),
                ),
              )
              .toList(),
          canAdvance: state.goal != null,
          onNext: cubit.nextStep,
        );
      },
    );
  }
}
