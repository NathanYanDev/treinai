import 'package:flutter/material.dart';

/// TreinAI — Color System
/// Dark mode · Lime accent (#C6FF00)
abstract final class AppColors {
  // ---------------------------------------------------------------------------
  // Paleta bruta (não use diretamente nas telas — use os tokens semânticos)
  // ---------------------------------------------------------------------------

  // Pretos / fundos
  static const Color black = Color(
    0xFF0D0D0D,
  ); // fundo principal (splash, telas)
  static const Color grey950 = Color(0xFF111111); // variação quase-black
  static const Color grey900 = Color(0xFF1A1A1A); // cards / containers elevados
  static const Color grey850 = Color(0xFF1F1F1F); // cards secundários
  static const Color grey800 = Color(0xFF262626); // input fields, separadores
  static const Color grey700 = Color(0xFF333333); // bordas, divisores
  static const Color grey600 = Color(0xFF4D4D4D); // bordas suaves
  static const Color grey500 = Color(0xFF666666); // placeholder, ícone inativo
  static const Color grey400 = Color(0xFF999999); // texto terciário / hint
  static const Color grey300 = Color(0xFFCCCCCC); // texto secundário suave
  static const Color grey200 = Color(0xFFE0E0E0); // texto secundário

  // Brancos / textos
  static const Color white = Color(0xFFFFFFFF);
  static const Color white90 = Color(0xE6FFFFFF); // texto primário (90% opaco)
  static const Color white70 = Color(0xB3FFFFFF); // texto secundário

  // Lime (accent principal — "lime accent" do design system)
  static const Color lime500 = Color(
    0xFFC6FF00,
  ); // accent principal (botões, badges, checkmarks)
  static const Color lime400 = Color(0xFFD4FF4D); // lime claro (hover state)
  static const Color lime600 = Color(0xFFAAE000); // lime escuro (pressed state)
  static const Color limeSubtle = Color(
    0x1AC6FF00,
  ); // lime 10% — fundo de badge/tag

  // Status / feedback
  static const Color success = Color(
    0xFF4CAF50,
  ); // verde sucesso (treino concluído)
  static const Color successSubtle = Color(0x1A4CAF50);
  static const Color error = Color(0xFFFF4444); // vermelho erro / sair da conta
  static const Color errorSubtle = Color(0x1AFF4444);
  static const Color warning = Color(0xFFFF9800); // laranja aviso
  static const Color warningSubtle = Color(0x1AFF9800);

  // Streak / fire (sequência de treinos)
  static const Color fire = Color(0xFFFF6B35); // ícone 🔥 cor aproximada
  static const Color fireSubtle = Color(0x1AFF6B35);

  // ---------------------------------------------------------------------------
  // Tokens semânticos — use ESTES nas telas e widgets
  // ---------------------------------------------------------------------------

  // Backgrounds
  static const Color bgPrimary = black; // fundo principal das telas
  static const Color bgSecondary = grey900; // cards, bottom sheets
  static const Color bgTertiary = grey850; // cards aninhados, itens de lista
  static const Color bgElevated =
      grey800; // inputs, chips, elementos interativos
  static const Color bgAccent = limeSubtle; // fundo de elementos com accent

  // Borders
  static const Color borderDefault = grey700; // bordas padrão
  static const Color borderSubtle = grey800; // bordas suaves (inputs)
  static const Color borderAccent =
      lime500; // borda de seleção ativa (onboarding)
  static const Color borderFocus = lime500; // borda de input em foco

  // Text
  static const Color textPrimary = white; // títulos, texto principal
  static const Color textSecondary = white70; // subtítulos, labels
  static const Color textTertiary = grey400; // hints, metadados, rótulos
  static const Color textDisabled = grey500; // texto desabilitado
  static const Color textAccent = lime500; // links, valores destacados
  static const Color textOnAccent = black; // texto SOBRE fundo lime (botões)
  static const Color textDanger = error; // "Sair da conta", erros

  // Icons
  static const Color iconPrimary = white;
  static const Color iconSecondary = grey400;
  static const Color iconAccent = lime500;

  // Interactive — botões primários
  static const Color buttonPrimary = lime500; // fundo botão primário
  static const Color buttonPrimaryPressed = lime600; // pressed
  static const Color buttonPrimaryText = black; // texto do botão primário

  // Interactive — botões secundários / outline
  static const Color buttonSecondaryBorder = grey700;
  static const Color buttonSecondaryText = white;

  // Interactive — botões ghost / texto
  static const Color buttonGhostText = grey400;

  // Input fields
  static const Color inputBackground = grey800;
  static const Color inputBorder = grey700;
  static const Color inputBorderFocused = lime500;
  static const Color inputText = white;
  static const Color inputHint = grey500;
  static const Color inputLabel = grey400;

  // Cards de treino
  static const Color cardBackground = grey900;
  static const Color cardBorder = grey800;
  static const Color cardActiveBackground = grey850; // card do treino "HOJE"
  static const Color cardActiveBorder = lime500;

  // Tags de dias da semana (Seg, Ter, Qua...)
  static const Color dayTagActive = lime500; // dia ativo
  static const Color dayTagActiveText = black;
  static const Color dayTagInactive = grey800; // dia inativo
  static const Color dayTagInactiveText = grey400;

  // Progress / execution
  static const Color seriesDone = lime500; // série concluída
  static const Color seriesCurrent = lime500; // série atual (borda)
  static const Color seriesPending = grey800; // série pendente

  // Loading dots
  static const Color loadingDotActive = lime500;
  static const Color loadingDotDone = lime500;
  static const Color loadingDotPending = grey700;

  /// Stats na tela de treino concluído (mockup)
  static const Color statYellow = Color(0xFFFFD700);
  static const Color statTeal = Color(0xFF00FF9D);

  // Streak badge
  static const Color streakBackground = fireSubtle;
  static const Color streakBorder = fire;
  static const Color streakText = fire;

  // Overlays
  static const Color overlay = Color(0xCC0D0D0D); // overlay de modais 80%
  static const Color scrim = Color(0x800D0D0D); // scrim suave 50%

  // Divider
  static const Color divider = grey800;
}
