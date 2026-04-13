import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum _AiStepState { pending, done, active }

class _AiStep {
  const _AiStep({required this.label, required this.state});

  final String label;
  final _AiStepState state;
}

class AiGeneratingScreen extends StatefulWidget {
  const AiGeneratingScreen({super.key});

  @override
  State<AiGeneratingScreen> createState() => _AiGeneratingScreenState();
}

class _AiGeneratingScreenState extends State<AiGeneratingScreen> {
  static const _labels = <String>[
    'Analisando perfil',
    'Selecionando exercícios',
    'Montando divisão de treino...',
    'Calculando carga e descanso',
  ];

  int _phase = 0;
  Timer? _timer;

  List<_AiStep> get _steps {
    return List.generate(_labels.length, (i) {
      final _AiStepState s;
      if (_phase > i) {
        s = _AiStepState.done;
      } else if (_phase == i && _phase < _labels.length) {
        s = _AiStepState.active;
      } else {
        s = _AiStepState.pending;
      }
      return _AiStep(label: _labels[i], state: s);
    });
  }

  double get _ringProgress {
    final p = (_phase + 1) / (_labels.length + 1);
    return p.clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      if (!mounted) return;
      setState(() => _phase++);
      if (_phase >= _labels.length) {
        _timer?.cancel();
        Navigator.of(context).pushReplacementNamed(AppRoutes.workouts);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _PulseRingsPainter(color: AppColors.lime500)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    '04 · LOADING IA',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textTertiary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CustomPaint(
                      painter: _RingPainter(
                        progress: _ringProgress,
                        color: AppColors.lime500,
                      ),
                      child: Center(
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: AppColors.grey900,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bolt_rounded,
                            color: AppColors.lime500,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTypography.displayMd,
                      children: [
                        TextSpan(
                          text: 'Criando seu\n',
                          style: AppTypography.displayMd.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: 'treino ideal',
                          style: AppTypography.displayMd.copyWith(
                            color: AppColors.lime500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A IA está analisando suas respostas e montando um plano personalizado.',
                    style: AppTypography.bodyLg,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  ..._steps.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _StatusRow(step: s),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.step});

  final _AiStep step;

  @override
  Widget build(BuildContext context) {
    final isActive = step.state == _AiStepState.active;
    final isDone = step.state == _AiStepState.done;

    final borderW = isActive ? 2.0 : 1.0;
    final borderColor = isActive
        ? AppColors.lime500
        : (isDone ? AppColors.lime500 : AppColors.borderSubtle);
    final bg = isActive
        ? AppColors.lime500.withValues(alpha: 0.06)
        : AppColors.grey900;

    final dotColor = isDone || isActive
        ? AppColors.lime500
        : AppColors.grey700;

    final textColor = isActive
        ? AppColors.lime500
        : (isDone ? AppColors.textSecondary : AppColors.grey500);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: borderW),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              step.label,
              style: AppTypography.titleSm.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.shortestSide / 2 - 4;
    final bg = Paint()
      ..color = AppColors.grey800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, r, bg);

    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const start = -3.14159 / 2;
    final sweep = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      start,
      sweep,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _PulseRingsPainter extends CustomPainter {
  _PulseRingsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.28);
    final paint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(center, 50.0 + i * 40, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
