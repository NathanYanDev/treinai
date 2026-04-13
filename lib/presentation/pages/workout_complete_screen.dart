import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'workout_complete_args.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  const WorkoutCompleteScreen({super.key, this.args});

  final WorkoutCompleteArgs? args;

  WorkoutCompleteArgs get _a => args ?? WorkoutCompleteArgs.defaults();

  @override
  Widget build(BuildContext context) {
    final a = _a;
    final exStr = '${a.completedExercises}/${a.totalExercises}';

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, -0.4),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.lime500.withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '08 · TREINO CONCLUÍDO',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textTertiary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: AppColors.lime500,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.black,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Treino concluído! 🎉',
                    style: AppTypography.displayMd,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Você completou o ${a.workoutLabel} hoje.\nContinue assim para ver resultados reais.',
                    style: AppTypography.bodyLg,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      _StatCard(
                        value: exStr,
                        label: 'Exercícios',
                        valueColor: AppColors.lime500,
                      ),
                      _StatCard(
                        value: '${a.durationMinutes}min',
                        label: 'Duração',
                        valueColor: AppColors.textPrimary,
                      ),
                      _StatCard(
                        value: '${a.totalSets}',
                        label: 'Séries totais',
                        valueColor: AppColors.statYellow,
                      ),
                      _StatCard(
                        value: '${a.totalReps}',
                        label: 'Reps totais',
                        valueColor: AppColors.statTeal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _StreakCard(days: a.streakDays, isRecord: a.isNewRecord),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Histórico em breve.')),
                      );
                    },
                    child: const Text('VER HISTÓRICO'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.workouts,
                        (route) => false,
                      );
                    },
                    child: const Text('VOLTAR AO INÍCIO'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTypography.statValueXl.copyWith(color: valueColor),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.statLabel.copyWith(letterSpacing: 0.7),
          ),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.days, this.isRecord = false});

  final int days;
  final bool isRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.fire.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.fire.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sequência de $days dias!',
                  style: AppTypography.titleMd.copyWith(
                    color: AppColors.fire,
                  ),
                ),
                if (isRecord) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Novo recorde pessoal!',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textTertiary,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
