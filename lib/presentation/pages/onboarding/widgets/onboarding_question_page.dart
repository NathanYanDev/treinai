import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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

  String get _paddedStep => step.clamp(1, 99).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final showBack = onBack != null && step > 1;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                children: [
                  Text(
                    '$_paddedStep · ONBOARDING',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textTertiary,
                      letterSpacing: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  OnboardingProgressBar(
                    currentStep: step,
                    totalSteps: totalSteps,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ETAPA $step DE $totalSteps',
                      style: AppTypography.stepLabel,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
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
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (showBack) ...[
                    Material(
                      color: AppColors.bgElevated,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: onBack,
                        borderRadius: BorderRadius.circular(12),
                        child: const SizedBox(
                          width: 48,
                          height: 52,
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: AppColors.textPrimary,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: canAdvance ? 1.0 : 0.4,
                      duration: const Duration(milliseconds: 200),
                      child: ElevatedButton(
                        onPressed: canAdvance ? onNext : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(nextLabel, style: AppTypography.buttonLg),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.black,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
