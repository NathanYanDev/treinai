import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/models/workout_template.dart';
import '../../domain/workout_mock_data.dart';

const _kWeekShort = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  static String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Bom dia';
    if (h < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Novo treino em breve.')),
          );
        },
        child: const Icon(Icons.add, size: 32),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_greeting()} 👋',
                        style: AppTypography.titleSm,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'João Silva',
                        style: AppTypography.displaySm,
                      ),
                    ],
                  ),
                ),
                Material(
                  color: AppColors.lime500,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.profile);
                    },
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          'J',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sequência de treinos',
                          style: AppTypography.titleMd,
                        ),
                        Text(
                          'Continue assim!',
                          style: AppTypography.bodyMd,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '7',
                    style: AppTypography.statValueLg.copyWith(
                      color: AppColors.lime500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'SEUS TREINOS',
              style: AppTypography.headingSm.copyWith(
                color: AppColors.lime500,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            ...WorkoutMockData.templates.map(
              (w) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _WorkoutCard(
                  template: w,
                  isToday: w.scheduledWeekdays.contains(today),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.workoutDetail,
                      arguments: w,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({
    required this.template,
    required this.isToday,
    required this.onTap,
  });

  final WorkoutTemplate template;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isToday ? AppColors.cardActiveBorder : AppColors.cardBorder,
              width: isToday ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      template.listTitle,
                      style: isToday
                          ? AppTypography.headingMd.copyWith(
                              color: AppColors.lime500,
                            )
                          : AppTypography.headingMd,
                    ),
                  ),
                  if (isToday)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lime500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('HOJE', style: AppTypography.labelSm),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${template.exerciseCount} exercícios · ~${template.durationMinutes} min · Academia',
                style: AppTypography.bodyMd,
              ),
              const SizedBox(height: 12),
              Row(
                children: List.generate(7, (i) {
                  final weekday = i + 1;
                  final active = template.scheduledWeekdays.contains(weekday);
                  return Expanded(
                    child: Center(
                      child: Text(
                        _kWeekShort[i],
                        style: AppTypography.labelLg.copyWith(
                          fontSize: 11,
                          color: active
                              ? AppColors.lime500
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
