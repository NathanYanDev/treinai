import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/models/workout_template.dart';
import '../../domain/workout_mock_data.dart';

/// Letras dos dias: D S T Q Q S S (domingo primeiro)
const _kCalendarLetters = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

class WorkoutDetailScreen extends StatelessWidget {
  const WorkoutDetailScreen({super.key, required this.template});

  final WorkoutTemplate template;

  static WorkoutTemplate resolveArgs(Object? arguments) {
    if (arguments is WorkoutTemplate) return arguments;
    return WorkoutMockData.templates.first;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  _SquareIconButton(
                    icon: Icons.chevron_left_rounded,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  _SquareIconButton(
                    icon: Icons.more_vert_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Menu em breve.')),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                children: [
                  Text(
                    template.codeLabel,
                    style: AppTypography.bodyMd,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    template.muscleTitle,
                    style: AppTypography.headingLg,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryTile(
                          value: '${template.exerciseCount}',
                          bottom: 'Exercícios',
                          highlightValue: false,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SummaryTile(
                          value: '${template.durationMinutes}min',
                          bottom: 'Duração',
                          highlightValue: false,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SummaryTile(
                          value: '${template.sessionsHighlight}',
                          bottom: 'Séries',
                          highlightValue: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (i) {
                      final weekdayDart = i == 0 ? 7 : i;
                      final scheduled = template.scheduledWeekdays.contains(
                        weekdayDart,
                      );
                      final isToday = weekdayDart == today;
                      Color bg;
                      Color fg;
                      if (isToday) {
                        bg = AppColors.warning;
                        fg = AppColors.black;
                      } else if (scheduled) {
                        bg = AppColors.lime500;
                        fg = AppColors.black;
                      } else {
                        bg = AppColors.grey800;
                        fg = AppColors.textTertiary;
                      }
                      return Column(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: bg,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              _kCalendarLetters[i],
                              style: AppTypography.labelLg.copyWith(
                                color: fg,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'EXERCÍCIOS',
                    style: AppTypography.headingSm.copyWith(
                      color: AppColors.lime500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...template.exercises.asMap().entries.map((e) {
                    final i = e.key + 1;
                    final ex = e.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    i.toString().padLeft(2, '0'),
                                    style: AppTypography.bodySm,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(ex.name, style: AppTypography.titleMd),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${ex.sets} séries • ${ex.repsLabel} reps • ${ex.restSeconds}s',
                                    style: AppTypography.bodyMd,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.bgElevated,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.workoutExecution,
                    arguments: template,
                  );
                },
                child: const Text('INICIAR TREINO'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgElevated,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.value,
    required this.bottom,
    required this.highlightValue,
  });

  final String value;
  final String bottom;
  final bool highlightValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.statValueLg.copyWith(
              color: highlightValue ? AppColors.lime500 : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            bottom,
            style: AppTypography.statLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
