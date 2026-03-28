import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// TreinAI — Typography System
///
/// Syne   → Display, títulos grandes, headings (personalidade / força)
/// DM Sans → Corpo, labels, inputs, metadados (legibilidade)
///
/// Uso:
///   Text('Criando seu treino ideal', style: AppTypography.displayLg)
///   Text('joao@email.com', style: AppTypography.bodyMd)
abstract final class AppTypography {
  // ---------------------------------------------------------------------------
  // Font families base
  // ---------------------------------------------------------------------------
  static TextStyle get _syne => GoogleFonts.syne();
  static TextStyle get _dmSans => GoogleFonts.dmSans();

  // ---------------------------------------------------------------------------
  // DISPLAY — Syne · Telas: Splash, Loading IA, Treino Concluído
  // ---------------------------------------------------------------------------

  /// "Criando seu treino ideal" · "Treino concluído! 🎉"
  /// 32px · Bold (700) · Syne
  static TextStyle get displayLg => _syne.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.15,
    letterSpacing: -0.5,
  );

  /// "Bem-vindo de volta!" · 28px · Bold · Syne
  static TextStyle get displayMd => _syne.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.3,
  );

  /// "Qual é o seu objetivo?" · 24px · Bold · Syne
  static TextStyle get displaySm => _syne.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.25,
    letterSpacing: -0.2,
  );

  // ---------------------------------------------------------------------------
  // HEADING — Syne · Títulos de seção e cards
  // ---------------------------------------------------------------------------

  /// "Peito e Tríceps" (header do detalhe) · 22px · SemiBold · Syne
  static TextStyle get headingLg => _syne.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.2,
  );

  /// "Treino A — Peito e Tríceps" (card) · 18px · SemiBold · Syne
  static TextStyle get headingMd => _syne.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// "SEUS TREINOS" (label de seção) · 13px · Bold · Syne · uppercase
  static TextStyle get headingSm => _syne.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textTertiary,
    height: 1.4,
    letterSpacing: 1.2,
  );

  // ---------------------------------------------------------------------------
  // TITLE — DM Sans · Nomes de exercícios, nomes de usuário
  // ---------------------------------------------------------------------------

  /// "Crossover" (exercício atual na execução) · 20px · SemiBold · DM Sans
  static TextStyle get titleLg => _dmSans.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// "Supino Reto" (lista de exercícios) · 16px · SemiBold · DM Sans
  static TextStyle get titleMd => _dmSans.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  /// "Bom dia 👋" / "João Silva" · 14px · Medium · DM Sans
  static TextStyle get titleSm => _dmSans.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ---------------------------------------------------------------------------
  // BODY — DM Sans · Corpo de texto, descrições
  // ---------------------------------------------------------------------------

  /// Descrições de opções no onboarding · 15px · Regular · DM Sans
  static TextStyle get bodyLg => _dmSans.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  /// Metadados de cards ("8 exercícios · ~55 min") · 13px · Regular · DM Sans
  static TextStyle get bodyMd => _dmSans.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  /// Hints, rótulos de input ("EMAIL") · 11px · Medium · DM Sans
  static TextStyle get bodySm => _dmSans.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.4,
    letterSpacing: 0.8,
  );

  // ---------------------------------------------------------------------------
  // LABEL — DM Sans · Tags, badges, chips
  // ---------------------------------------------------------------------------

  /// Dias da semana ("Seg", "Ter") · 12px · SemiBold · DM Sans
  static TextStyle get labelLg => _dmSans.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  /// "HOJE", "EM ANDAMENTO" · 10px · Bold · DM Sans · uppercase
  static TextStyle get labelSm => _dmSans.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnAccent,
    height: 1.0,
    letterSpacing: 0.8,
  );

  // ---------------------------------------------------------------------------
  // BUTTON — DM Sans · Textos de botões
  // ---------------------------------------------------------------------------

  /// "ENTRAR", "PRÓXIMO", "INICIAR TREINO" · 15px · Bold · DM Sans
  static TextStyle get buttonLg => _dmSans.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnAccent,
    height: 1.0,
    letterSpacing: 0.3,
  );

  /// "CRIAR CONTA", "PULAR SÉRIE" (secondary) · 14px · SemiBold · DM Sans
  static TextStyle get buttonMd => _dmSans.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  /// Texto de link ("Esqueci minha senha") · 13px · Medium · DM Sans
  static TextStyle get link => _dmSans.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textAccent,
    height: 1.4,
  );

  // ---------------------------------------------------------------------------
  // NUMERIC — Syne · Estatísticas em destaque (Detalhe e Conclusão)
  // ---------------------------------------------------------------------------

  /// "8", "55min", "3×" (stats do detalhe) · 24px · Bold · Syne
  static TextStyle get statValueLg => _syne.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  /// "288", "24" (reps/séries no concluído) · 28px · Bold · Syne · accent
  static TextStyle get statValueXl => _syne.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.lime500,
    height: 1.1,
  );

  /// "Exercícios", "Duração" (label das stats) · 11px · Regular · DM Sans
  static TextStyle get statLabel => _dmSans.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.4,
  );

  // ---------------------------------------------------------------------------
  // INPUT — DM Sans · Textos dentro de inputs
  // ---------------------------------------------------------------------------

  /// Valor digitado no input · 15px · Regular · DM Sans
  static TextStyle get inputValue => _dmSans.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.inputText,
    height: 1.5,
  );

  /// Placeholder do input · 15px · Regular · DM Sans
  static TextStyle get inputHint => _dmSans.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.inputHint,
    height: 1.5,
  );

  // ---------------------------------------------------------------------------
  // LOGO — Syne · "TreinAI" no splash e no header
  // ---------------------------------------------------------------------------

  /// "TreinAI" (splash) · 28px · Bold · Syne
  static TextStyle get logo => _syne.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.0,
    letterSpacing: -0.5,
  );

  /// "SEU PERSONAL INTELIGENTE" (subtítulo do splash) · 11px · Medium · DM Sans
  static TextStyle get logoSubtitle => _dmSans.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.4,
    letterSpacing: 2.0,
  );

  // ---------------------------------------------------------------------------
  // ETAPA — DM Sans · "ETAPA 3 DE 5" no onboarding
  // ---------------------------------------------------------------------------
  static TextStyle get stepLabel => _dmSans.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.lime500,
    height: 1.4,
    letterSpacing: 0.5,
  );
}
