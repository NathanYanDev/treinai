import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/models/workout_days_per_week.dart';
import 'widgets/onboarding_question_page.dart';

class OnboardingDaysPerWeekPage extends StatelessWidget {
  const OnboardingDaysPerWeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return OnboardingQuestionPage(
          step: 3,
          title: 'Dias por semana',
          subtitle: 'Quantidade de dias por semana que você treina',
          options: WorkoutDaysPerWeek.values
              .map(
                (daysPerWeek) => OnboardingOption(
                  title: daysPerWeek.label,
                  subtitle: daysPerWeek.description,
                  isSelected: state.daysPerWeek == daysPerWeek,
                  onTap: () => cubit.setDaysPerWeek(daysPerWeek),
                ),
              )
              .toList(),
          canAdvance: state.daysPerWeek != null,
          onNext: cubit.nextStep,
          onBack: cubit.previousStep,
        );
      },
    );
  }
}
