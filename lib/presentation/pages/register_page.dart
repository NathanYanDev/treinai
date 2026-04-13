import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Criar conta', style: AppTypography.headingMd),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Cadastro completo em breve. Por enquanto use Entrar para continuar.',
                style: AppTypography.bodyLg,
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
                child: const Text('VOLTAR AO LOGIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
