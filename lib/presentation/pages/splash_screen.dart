import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/repositories/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed && mounted) {
        try {
          final session = await context.read<AuthRepository>().getCurrentSession();

          if (!mounted) return;

          if (session != null) {
            // Já logado: Pula direto para a lista de treinos
            Navigator.of(context).pushReplacementNamed(AppRoutes.workouts);
          } else {
            // Não logado: Vai para o login
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          }
        } catch (_) {
          if (!mounted) return;
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _PulseRingsPainter(color: AppColors.lime500)),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                _LogoBlock(animation: _controller),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 0, 48, 48),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          value: _controller.value,
                          minHeight: 4,
                          backgroundColor: AppColors.grey800,
                          color: AppColors.lime500,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  const _LogoBlock({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0, 0.5, curve: Curves.easeOutCubic),
            ),
          ),
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.lime500,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(Icons.bolt_rounded, color: AppColors.black, size: 48),
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTypography.logo,
            children: [
              TextSpan(
                text: 'Trein',
                style: AppTypography.logo.copyWith(color: AppColors.textPrimary),
              ),
              TextSpan(
                text: 'AI',
                style: AppTypography.logo.copyWith(color: AppColors.lime500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'SEU PERSONAL INTELIGENTE',
          style: AppTypography.logoSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PulseRingsPainter extends CustomPainter {
  _PulseRingsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.38);
    final paint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 1; i <= 5; i++) {
      final r = 60.0 + i * 48;
      canvas.drawCircle(center, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
