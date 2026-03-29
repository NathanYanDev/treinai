import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'João Silva');
  final _emailController = TextEditingController(text: 'joao@email.com');
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onChanged);
    _emailController.addListener(_onChanged);
    _passwordController.addListener(_onChanged);
    _confirmPasswordController.addListener(_onChanged);
  }

  void _onChanged() {
    if (!_hasChanges) setState(() => _hasChanges = true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: chamar cubit/bloc para salvar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Perfil atualizado com sucesso!',
          style: AppTypography.bodyMd.copyWith(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.bgSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context);
  }

  void _confirmDiscard() {
    if (!_hasChanges) {
      Navigator.pop(context);
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (ctx) => _DiscardSheet(
        onDiscard: () {
          Navigator.pop(ctx);
          Navigator.pop(context);
        },
        onKeep: () => Navigator.pop(ctx),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.iconPrimary,
          onPressed: _confirmDiscard,
        ),
        title: Text('Editar perfil', style: AppTypography.headingMd),
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 8),

            Center(
              child: Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.lime500,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'J',
                      style: AppTypography.displayMd.copyWith(
                        color: AppColors.textOnAccent,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.bgElevated,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.bgPrimary,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        size: 13,
                        color: AppColors.iconSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

  
            _SectionLabel(label: 'DADOS PESSOAIS'),
            const SizedBox(height: 12),

            _AppTextField(
              controller: _nameController,
              label: 'NOME',
              hint: 'Seu nome completo',
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Informe seu nome';
                if (v.trim().length < 2) return 'Nome muito curto';
                return null;
              },
            ),

            const SizedBox(height: 12),

            _AppTextField(
              controller: _emailController,
              label: 'EMAIL',
              hint: 'seu@email.com',
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Informe o e-mail';
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(v.trim())) return 'E-mail inválido';
                return null;
              },
            ),

            const SizedBox(height: 28),

            _SectionLabel(label: 'SEGURANÇA'),
            const SizedBox(height: 6),
            Text(
              'Deixe em branco para manter a senha atual.',
              style: AppTypography.bodyMd,
            ),
            const SizedBox(height: 12),

            _AppTextField(
              controller: _passwordController,
              label: 'NOVA SENHA',
              hint: '••••••••',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: AppColors.iconSecondary,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return null; // opcional
                if (v.length < 6) return 'Mínimo 6 caracteres';
                return null;
              },
            ),

            const SizedBox(height: 12),

            _AppTextField(
              controller: _confirmPasswordController,
              label: 'CONFIRMAR SENHA',
              hint: '••••••••',
              obscureText: _obscureConfirm,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: AppColors.iconSecondary,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              validator: (v) {
                if (_passwordController.text.isEmpty) return null;
                if (v != _passwordController.text) return 'Senhas não coincidem';
                return null;
              },
            ),

            const SizedBox(height: 40),

  
            ElevatedButton(
              onPressed: _hasChanges ? _save : null,
              child: const Text('SALVAR ALTERAÇÕES'),
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: _confirmDiscard,
              child: const Text('CANCELAR'),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}


class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTypography.headingSm);
  }
}


class _AppTextField extends StatelessWidget {
  const _AppTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySm),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          style: AppTypography.inputValue,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}


class _DiscardSheet extends StatelessWidget {
  const _DiscardSheet({
    required this.onDiscard,
    required this.onKeep,
  });

  final VoidCallback onDiscard;
  final VoidCallback onKeep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text('Descartar alterações?', style: AppTypography.headingMd),
          const SizedBox(height: 8),
          Text(
            'Você tem mudanças não salvas. Se sair agora, elas serão perdidas.',
            style: AppTypography.bodyLg,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onKeep,
            child: const Text('CONTINUAR EDITANDO'),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: onDiscard,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textDanger,
              side: BorderSide(
                color: AppColors.error.withValues(alpha: 0.4),
              ),
            ),
            child: const Text('DESCARTAR'),
          ),
        ],
      ),
    );
  }
}