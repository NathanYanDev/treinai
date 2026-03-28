import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// TreinAI — Theme
///
/// Uso no MaterialApp:
///   MaterialApp(
///     theme: AppTheme.dark,      // único tema (dark-only por ora)
///     debugShowCheckedModeBanner: false,
///   )
abstract final class AppTheme {
  static ThemeData get dark => _buildDarkTheme();

  static ThemeData _buildDarkTheme() {
    // Base color scheme dark
    const colorScheme = ColorScheme.dark(
      brightness: Brightness.dark,
      // Superfícies
      surface: AppColors.bgPrimary,
      surfaceContainerHighest: AppColors.bgSecondary,
      // Primária (accent lime)
      primary: AppColors.lime500,
      onPrimary: AppColors.black,
      primaryContainer: AppColors.limeSubtle,
      onPrimaryContainer: AppColors.lime500,
      // Secundária
      secondary: AppColors.grey700,
      onSecondary: AppColors.white,
      // Erro
      error: AppColors.error,
      onError: AppColors.white,
      errorContainer: AppColors.errorSubtle,
      // Texto / ícones sobre superfícies
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      // Outline
      outline: AppColors.borderDefault,
      outlineVariant: AppColors.borderSubtle,
      // Scrim
      scrim: AppColors.scrim,
    );

    final textTheme = _buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      textTheme: textTheme,
      primaryTextTheme: textTheme,

      // ── AppBar ──────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgPrimary,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.headingMd,
        iconTheme: const IconThemeData(color: AppColors.iconPrimary),
        actionsIconTheme: const IconThemeData(color: AppColors.iconPrimary),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.bgPrimary,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      // ── ElevatedButton (botão primário — lime) ───────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              foregroundColor: AppColors.buttonPrimaryText,
              disabledBackgroundColor: AppColors.grey700,
              disabledForegroundColor: AppColors.grey500,
              elevation: 0,
              shadowColor: Colors.transparent,
              minimumSize: const Size(double.infinity, 52),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: AppTypography.buttonLg,
            ).copyWith(
              // pressed → lime mais escuro
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.buttonPrimaryPressed;
                }
                if (states.contains(WidgetState.disabled)) {
                  return AppColors.grey700;
                }
                return AppColors.buttonPrimary;
              }),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
      ),

      // ── OutlinedButton (botão secundário — ghost com borda) ─────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(
                color: AppColors.buttonSecondaryBorder,
                width: 1,
              ),
              minimumSize: const Size(double.infinity, 52),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: AppTypography.buttonMd,
            ).copyWith(
              side: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return const BorderSide(color: AppColors.lime500, width: 1);
                }
                return const BorderSide(
                  color: AppColors.buttonSecondaryBorder,
                  width: 1,
                );
              }),
            ),
      ),

      // ── TextButton (link style — "Esqueci minha senha") ──────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textAccent,
          textStyle: AppTypography.link,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // ── InputDecoration (campos de email, senha) ──────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        // Borda padrão
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
        ),
        // Borda focada
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.inputBorderFocused,
            width: 1.5,
          ),
        ),
        // Borda com erro
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
        // Estilos de texto
        hintStyle: AppTypography.inputHint,
        labelStyle: AppTypography.bodySm.copyWith(color: AppColors.inputLabel),
        floatingLabelStyle: AppTypography.bodySm.copyWith(
          color: AppColors.lime500,
        ),
        errorStyle: AppTypography.bodySm.copyWith(
          color: AppColors.error,
          letterSpacing: 0,
        ),
        // Label de seção (EMAIL, SENHA — uppercase no design)
        prefixIconColor: AppColors.iconSecondary,
        suffixIconColor: AppColors.iconSecondary,
      ),

      // ── Card ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.cardBorder, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // ── Divider ──────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── BottomNavigationBar ───────────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bgSecondary,
        selectedItemColor: AppColors.lime500,
        unselectedItemColor: AppColors.iconSecondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // ── NavigationBar (M3) ────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.bgSecondary,
        indicatorColor: AppColors.limeSubtle,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.lime500);
          }
          return const IconThemeData(color: AppColors.iconSecondary);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.labelLg.copyWith(color: AppColors.lime500);
          }
          return AppTypography.labelLg.copyWith(color: AppColors.iconSecondary);
        }),
      ),

      // ── Chip ─────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.bgElevated,
        selectedColor: AppColors.limeSubtle,
        side: const BorderSide(color: AppColors.borderDefault, width: 1),
        labelStyle: AppTypography.labelLg,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // ── ListTile (itens de configurações no perfil) ───────────────────────
      listTileTheme: ListTileThemeData(
        tileColor: AppColors.bgTertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        titleTextStyle: AppTypography.titleSm,
        subtitleTextStyle: AppTypography.bodyMd,
        leadingAndTrailingTextStyle: AppTypography.bodyMd.copyWith(
          color: AppColors.textTertiary,
        ),
        iconColor: AppColors.iconSecondary,
      ),

      // ── Switch ────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.black;
          return AppColors.grey500;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.lime500;
          return AppColors.grey700;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── Checkbox ─────────────────────────────────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.lime500;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.black),
        side: const BorderSide(color: AppColors.borderDefault, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // ── Progress Indicator ────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.lime500,
        linearTrackColor: AppColors.grey800,
        circularTrackColor: AppColors.grey800,
      ),

      // ── SnackBar ──────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.bgSecondary,
        contentTextStyle: AppTypography.bodyMd.copyWith(
          color: AppColors.textPrimary,
        ),
        actionTextColor: AppColors.lime500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),

      // ── Bottom Sheet ──────────────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bgSecondary,
        modalBackgroundColor: AppColors.bgSecondary,
        elevation: 0,
        modalElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.grey700,
        dragHandleSize: Size(40, 4),
      ),

      // ── Dialog ────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.bgSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: AppTypography.headingMd,
        contentTextStyle: AppTypography.bodyLg,
      ),

      // ── FloatingActionButton (botão + da lista de treinos) ────────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lime500,
        foregroundColor: AppColors.black,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: CircleBorder(),
      ),

      // ── Icon ──────────────────────────────────────────────────────────────
      iconTheme: const IconThemeData(color: AppColors.iconPrimary, size: 24),
      primaryIconTheme: const IconThemeData(color: AppColors.lime500, size: 24),

      // ── Page transitions ──────────────────────────────────────────────────
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // ── Misc ──────────────────────────────────────────────────────────────
      splashColor: AppColors.limeSubtle,
      highlightColor: Colors.transparent,
      hoverColor: AppColors.limeSubtle,
      focusColor: AppColors.limeSubtle,
      disabledColor: AppColors.grey600,
      visualDensity: VisualDensity.standard,
    );
  }

  // ---------------------------------------------------------------------------
  // TextTheme — mapeia roles M3 para os estilos do TreinAI
  // ---------------------------------------------------------------------------
  static TextTheme _buildTextTheme() {
    return TextTheme(
      // Display
      displayLarge: AppTypography.displayLg,
      displayMedium: AppTypography.displayMd,
      displaySmall: AppTypography.displaySm,
      // Headline
      headlineLarge: AppTypography.headingLg,
      headlineMedium: AppTypography.headingMd,
      headlineSmall: AppTypography.headingSm,
      // Title
      titleLarge: AppTypography.titleLg,
      titleMedium: AppTypography.titleMd,
      titleSmall: AppTypography.titleSm,
      // Body
      bodyLarge: AppTypography.bodyLg,
      bodyMedium: AppTypography.bodyMd,
      bodySmall: AppTypography.bodySm,
      // Label
      labelLarge: AppTypography.labelLg,
      labelMedium: AppTypography.labelSm,
      labelSmall: AppTypography.statLabel,
    );
  }
}

// ---------------------------------------------------------------------------
// Extensão de conveniência — acesso rápido ao tema em qualquer widget
// ---------------------------------------------------------------------------
extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Atalhos para estilos frequentes
  TextStyle get displayLg => AppTypography.displayLg;
  TextStyle get headingMd => AppTypography.headingMd;
  TextStyle get bodyMd => AppTypography.bodyMd;
  TextStyle get labelSm => AppTypography.labelSm;
}
