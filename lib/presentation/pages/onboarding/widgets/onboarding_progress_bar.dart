import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingProgressBar extends StatelessWidget {
  const OnboardingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isFilled = index < currentStep;
        final isLast = index == totalSteps - 1;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 6),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 3,
              decoration: BoxDecoration(
                color: isFilled ? AppColors.lime500 : AppColors.grey800,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        );
      }),
    );
  }
}
