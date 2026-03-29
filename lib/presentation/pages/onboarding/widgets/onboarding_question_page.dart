import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import 'onboarding_option_card.dart';
import 'onboarding_progress_bar.dart';

class OnboardingOption {
  const OnboardingOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.emoji,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final String? emoji;
  final bool isSelected;
  final VoidCallback onTap;
}

class OnboardingQuestionPage extends StatelessWidget {
  const OnboardingQuestionPage({
    super.key,
    required this.step,
    required this.title,
    required this.options,
    required this.canAdvance,
    required this.onNext,
    this.subtitle,
    this.totalSteps = 9,
    this.nextLabel = 'PRÓXIMO',
    this.onBack,
  });

  final int step;
  final int totalSteps;
  final String title;
  final String? subtitle;
  final List<OnboardingOption> options;
  final bool canAdvance;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final String nextLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (onBack != null) ...[
                        GestureDetector(
                          onTap: onBack,
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.iconSecondary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Text(
                        'ETAPA $step DE $totalSteps',
                        style: AppTypography.stepLabel,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  OnboardingProgressBar(
                    currentStep: step,
                    totalSteps: totalSteps,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.displaySm),
                    if (subtitle != null) ...[
                      const SizedBox(height: 8),
                      Text(subtitle!, style: AppTypography.bodyLg),
                    ],
                    const SizedBox(height: 32),
                    ...options.map(
                      (option) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OnboardingOptionCard(
                          emoji: option.emoji,
                          title: option.title,
                          subtitle: option.subtitle,
                          isSelected: option.isSelected,
                          onTap: option.onTap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: AnimatedOpacity(
                opacity: canAdvance ? 1.0 : 0.4,
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                  onPressed: canAdvance ? onNext : null,
                  child: Text(nextLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
