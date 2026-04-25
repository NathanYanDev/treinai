import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/services/secure_storage_service.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Center(
                  child: Text(
                    '09 · PERFIL',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textTertiary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SUA CONTA',
                      style: AppTypography.headingSm,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Perfil',
                      style: AppTypography.displaySm,
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [

                    Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: AppColors.lime500,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'J',
                        style: AppTypography.displaySm.copyWith(
                          color: AppColors.textOnAccent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'João Silva',
                            style: AppTypography.titleLg,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'joao@email.com',
                            style: AppTypography.bodyMd,
                          ),
                        ],
                      ),
                    ),


                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.editProfile);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.bgElevated,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'EDITAR',
                        style: AppTypography.labelLg.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              _ProfileSection(
                title: 'MEU PERFIL DE TREINO',
                children: [
                  _ProfileRow(
                    icon: Icons.layers_outlined,
                    label: 'Objetivo',
                    value: 'Ganhar massa',
                  ),
                  _ProfileRow(
                    icon: Icons.location_on_outlined,
                    label: 'Local de treino',
                    value: 'Academia',
                  ),
                  _ProfileRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Frequência',
                    value: '4× semana',
                  ),
                  _ProfileRow(
                    icon: Icons.person_outline,
                    label: 'Nível',
                    value: 'Intermediário',
                  ),
                ],
              ),


              _ProfileSection(
                title: 'CONFIGURAÇÕES',
                children: [
                  _ProfileRow(
                    icon: Icons.notifications_outlined,
                    label: 'Notificações',
                    showArrow: true,
                    onTap: () {
                      // TODO: navegar para notificações
                    },
                  ),
                  _ProfileRow(
                    icon: Icons.logout_rounded,
                    label: 'Sair da conta',
                    isDestructive: true,
                    onTap: () async {
                      final storageService = SecureStorageService();
                      await storageService.deleteToken();

                      if (!context.mounted) return;
                      
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}


class _ProfileSection extends StatelessWidget {
  const _ProfileSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.headingSm.copyWith(
              color: AppColors.lime500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}


class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.label,
    this.value,
    this.showArrow = false,
    this.isDestructive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? value;
  final bool showArrow;
  final bool isDestructive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color rowColor =
        isDestructive ? AppColors.textDanger : AppColors.textPrimary;

    final Color iconBg = isDestructive
        ? AppColors.error.withValues(alpha: 0.10)
        : AppColors.bgElevated;

    final Color borderColor = isDestructive
        ? AppColors.error.withValues(alpha: 0.25)
        : AppColors.cardBorder;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            // Ícone com fundo
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: rowColor),
            ),
            const SizedBox(width: 12),

     
            Expanded(
              child: Text(
                label,
                style: AppTypography.titleSm.copyWith(color: rowColor),
              ),
            ),

        
            if (value != null) ...[
              const SizedBox(width: 8),
              Text(
                value!,
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],

            if (showArrow) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: AppColors.iconSecondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}