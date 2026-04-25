import 'package:flutter/material.dart';

import '../../../core/services/secure_storage_service.dart';
import '../../../app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _storageService = SecureStorageService();

  final TextEditingController _emailController = TextEditingController(
    text: 'joao@email.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '123456',
  );
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // ── Logo ──────────────────────────────────────────────────────
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.lime500,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: AppColors.black,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Trein',
                          style: AppTypography.logo.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: 'AI',
                          style: AppTypography.logo.copyWith(
                            color: AppColors.lime500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── Headline ──────────────────────────────────────────────────
              Text('Bem-vindo\nde volta!', style: AppTypography.displayMd),

              const SizedBox(height: 10),

              Text(
                'Entre para continuar seu treino personalizado.',
                style: AppTypography.bodyLg,
              ),

              const SizedBox(height: 40),

              // ── Email ─────────────────────────────────────────────────────
              Text('EMAIL', style: AppTypography.bodySm),

              const SizedBox(height: 8),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: AppTypography.inputValue,
                decoration: InputDecoration(
                  // Campo preenchido → fundo levemente esverdeado + borda lime
                  filled: true,
                  fillColor: AppColors.bgAccent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.borderAccent,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.borderFocus,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Senha ─────────────────────────────────────────────────────
              Text('SENHA', style: AppTypography.bodySm),

              const SizedBox(height: 8),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: AppTypography.inputValue,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.iconSecondary,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),

              // ── Esqueci minha senha ───────────────────────────────────────
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Recuperação de senha em breve.'),
                      ),
                    );
                  },
                  child: Text('Esqueci minha senha', style: AppTypography.link),
                ),
              ),

              const SizedBox(height: 8),

              // ── Botões ────────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text.trim();
                        final pass = _passwordController.text.trim();
                        if (email.isEmpty || pass.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Preencha email e senha.'),
                            ),
                          );
                          return;
                        }
                        // Simulação, trocar depois.
                        const mockToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.MockToken";

                        await _storageService.saveToken(mockToken);

                        if (!mounted) return;

                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.onboarding,
                        );
                      },
                      child: Text('ENTRAR', style: AppTypography.buttonLg),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.register);
                      },
                      child: Text('CRIAR CONTA', style: AppTypography.buttonMd),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Divisor "ou" ──────────────────────────────────────────────
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text('ou', style: AppTypography.bodyMd),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              // ── Google ────────────────────────────────────────────────────
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Google Sign-In em breve.')),
                  );
                },
                icon: const Icon(
                  Icons.language,
                  color: AppColors.iconSecondary,
                  size: 20,
                ),
                label: Text(
                  'Continuar com Google',
                  style: AppTypography.buttonMd,
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
