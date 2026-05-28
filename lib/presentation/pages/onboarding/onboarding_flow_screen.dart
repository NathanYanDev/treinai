import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_routes.dart';
import '../../bloc/onboarding_cubit.dart';
import '../../bloc/onboarding_state.dart';
import '../../../domain/repositories/auth_repository.dart';
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
        authRepository: context.read<AuthRepository>(),
      ),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listenWhen: (prev, curr) =>
            prev.status == OnboardingStatus.loading &&
            curr.status != OnboardingStatus.loading,
        listener: (context, state) {
          if (state.status == OnboardingStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ??
                      'Não foi possível concluir o onboarding.',
                ),
              ),
            );
            return;
          }

          final onboarding = state.submittedOnboarding;
          if (onboarding == null) return;

          Navigator.of(context).pushReplacementNamed(
            AppRoutes.aiLoading,
            arguments: onboarding,
          );
        },
        child: const OnboardingRouter(),
      ),
    );
  }
}
