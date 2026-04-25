import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_routes.dart';
import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/repositories/onboarding_repository.dart';
import 'onboarding_router.dart';

/// Fornece o [OnboardingCubit] e navega para loading IA ao concluir.
class OnboardingFlowScreen extends StatelessWidget {
  const OnboardingFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(
        repository: context.read<OnboardingRepository>(),
      ),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listenWhen: (prev, curr) => curr.hasSubmitted && !prev.hasSubmitted,
        listener: (context, state) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.aiLoading);
        },
        child: const OnboardingRouter(),
      ),
    );
  }
}
