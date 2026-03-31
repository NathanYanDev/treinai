import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  const WorkoutCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          // ── Glow de fundo ─────────────────────────────────────────────
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

          // ── Conteúdo ──────────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // — Hero section —
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
                    'Incrível! Você completou o Treino A hoje.\nContinue assim para ver resultados reais.',
                    style: AppTypography.bodyLg,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // — Stats grid —
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5, // 👈 ajustado
                    children: const [
                      _StatCard(
                        value: '8/8',
                        label: 'Exercícios',
                        highlight: true,
                      ),
                      _StatCard(value: '52min', label: 'Duração'),
                      _StatCard(value: '24', label: 'Séries totais'),
                      _StatCard(value: '288', label: 'Reps totais'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // — Streak card —
                  const _StreakCard(days: 8, isRecord: true),

                  const SizedBox(height: 40),

                  // — Botões —
                  ElevatedButton(
                    onPressed: () {
                      // TODO: navegar para histórico
                    },
                    child: const Text('VER HISTÓRICO'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/workouts',
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

// ─────────────────────────────────────────────────────────────────────────────
// _StatCard
// ─────────────────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final String value;
  final String label;
  final bool highlight;

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
        mainAxisAlignment: MainAxisAlignment.center, // 👈 centraliza
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: highlight
                ? AppTypography.statValueXl
                : AppTypography.statValueXl.copyWith(
                    color: AppColors.textPrimary,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // 👈 evita quebrar layout
            style: AppTypography.statLabel.copyWith(letterSpacing: 0.7),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _StreakCard
// ─────────────────────────────────────────────────────────────────────────────
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
                    'Novo recorde pessoal! 🏆',
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