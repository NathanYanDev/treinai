import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';

import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import 'onboarding_age_range_page.dart';
import 'onboarding_duration_page.dart';
import 'onboarding_gender_page.dart';
import 'onboarding_goal_page.dart';
import 'onboarding_location_page.dart';
import 'onboarding_days_per_week_page.dart';
import 'onboarding_level_page.dart';
import 'onboarding_physical_limitation_page.dart';
import 'onboarding_muscular_focus_page.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreinAI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: BlocProvider(
        create: (_) => OnboardingCubit(),
        child: const OnboardingRouter(),
      ),
    );
  }
}

class OnboardingRouter extends StatelessWidget {
  const OnboardingRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (prev, curr) => prev.currentStep != curr.currentStep,
      builder: (context, state) {
        return switch (state.currentStep) {
          1 => const OnboardingGoalPage(),
          2 => const OnboardingLocationPage(),
          3 => const OnboardingDaysPerWeekPage(),
          4 => const OnboardingDurationPage(),
          5 => const OnboardingLevelPage(),
          6 => const OnboardingGenderPage(),
          7 => const OnboardingAgeRangePage(),
          8 => const OnboardingPhysicalLimitationPage(),
          9 => const OnboardingMuscularFocusPage(),
          _ => const OnboardingGoalPage(),
        };
      },
    );
  }
}
