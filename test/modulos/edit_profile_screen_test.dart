import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:treinai/core/theme/app_theme.dart';
import 'package:treinai/presentation/pages/edit_profile_screen.dart';

// Envolve a EditProfileScreen com um nível de navegação acima
// para permitir testar Navigator.pop corretamente
Widget _wrapWithNav() {
  return MaterialApp(
    theme: AppTheme.dark,
    home: Builder(
      builder: (ctx) => Scaffold(
        body: ElevatedButton(
          onPressed: () => Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => const EditProfileScreen()),
          ),
          child: const Text('Abrir'),
        ),
      ),
    ),
  );
}

// Abre a tela diretamente (sem precisar testar pop)
Widget _wrapDirect() {
  return MaterialApp(theme: AppTheme.dark, home: const EditProfileScreen());
}

// Helper — rola até um finder e aguarda estabilização
Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    100,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pump();
}

void main() {
  group('EditProfileScreen', () {
    // ── Renderização inicial ───────────────────────────────────────────────

    testWidgets(
      'DADO que o usuário abre a edição de perfil '
      'QUANDO a tela é exibida '
      'ENTÃO os campos devem estar pré-preenchidos com nome e email',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pump();

        expect(find.text('Editar perfil'), findsOneWidget);

        final nameField = tester.widget<EditableText>(
          find.descendant(
            of: find.byType(TextFormField).first,
            matching: find.byType(EditableText),
          ),
        );
        expect(nameField.controller.text, 'João Silva');

        final emailField = tester.widget<EditableText>(
          find.descendant(
            of: find.byType(TextFormField).at(1),
            matching: find.byType(EditableText),
          ),
        );
        expect(emailField.controller.text, 'joao@email.com');
      },
    );

    // ── Estado do botão salvar ─────────────────────────────────────────────

    testWidgets(
      'DADO que a tela foi aberta sem nenhuma alteração '
      'QUANDO a tela é exibida '
      'ENTÃO o botão "SALVAR ALTERAÇÕES" deve estar desabilitado',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('SALVAR ALTERAÇÕES'));

        final salvarFinder = find.ancestor(
          of: find.text('SALVAR ALTERAÇÕES'),
          matching: find.byType(ElevatedButton),
        );

        expect(salvarFinder, findsOneWidget);
        final saveButton = tester.widget<ElevatedButton>(salvarFinder);
        expect(saveButton.onPressed, isNull);
      },
    );

    testWidgets(
      'DADO que a tela está aberta '
      'QUANDO o usuário altera qualquer campo '
      'ENTÃO o botão "SALVAR ALTERAÇÕES" deve ficar habilitado',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).first, 'Novo Nome');
        await tester.pump();

        await _scrollTo(tester, find.text('SALVAR ALTERAÇÕES'));

        final salvarFinder = find.ancestor(
          of: find.text('SALVAR ALTERAÇÕES'),
          matching: find.byType(ElevatedButton),
        );

        final saveButton = tester.widget<ElevatedButton>(salvarFinder);
        expect(saveButton.onPressed, isNotNull);
      },
    );

    // ── Validações ─────────────────────────────────────────────────────────

    testWidgets(
      'DADO que o usuário tenta salvar '
      'QUANDO o campo nome está vazio '
      'ENTÃO deve exibir "Informe seu nome"',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).first, '');
        // Outra alteração para habilitar o botão
        await tester.enterText(
          find.byType(TextFormField).at(1),
          'novo@email.com',
        );
        await tester.pump();

        await _scrollTo(tester, find.text('SALVAR ALTERAÇÕES'));
        await tester.tap(find.text('SALVAR ALTERAÇÕES'));
        await tester.pump();

        expect(find.text('Informe seu nome'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o usuário tenta salvar '
      'QUANDO o email é inválido '
      'ENTÃO deve exibir "E-mail inválido"',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byType(TextFormField).at(1),
          'emailinvalido',
        );
        await tester.pump();

        await _scrollTo(tester, find.text('SALVAR ALTERAÇÕES'));
        await tester.tap(find.text('SALVAR ALTERAÇÕES'));
        await tester.pump();

        expect(find.text('E-mail inválido'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o usuário preencheu nova senha '
      'QUANDO a senha tem menos de 6 caracteres '
      'ENTÃO deve exibir "Mínimo 6 caracteres"',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        // Rola até o campo antes de preencher
        await _scrollTo(tester, find.byType(TextFormField).at(2));
        await tester.enterText(find.byType(TextFormField).at(2), '123');
        await tester.pump();

        await _scrollTo(tester, find.text('SALVAR ALTERAÇÕES'));
        await tester.tap(find.text('SALVAR ALTERAÇÕES'));
        await tester.pump();

        expect(find.text('Mínimo 6 caracteres'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o usuário preencheu nova senha '
      'QUANDO a confirmação não corresponde '
      'ENTÃO deve exibir "Senhas não coincidem"',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.byType(TextFormField).at(2));
        await tester.enterText(find.byType(TextFormField).at(2), 'senha123');

        await _scrollTo(tester, find.byType(TextFormField).at(3));
        await tester.enterText(find.byType(TextFormField).at(3), 'outrasenha');
        await tester.pump();

        await _scrollTo(tester, find.text('SALVAR ALTERAÇÕES'));
        await tester.tap(find.text('SALVAR ALTERAÇÕES'));
        await tester.pump();

        expect(find.text('Senhas não coincidem'), findsOneWidget);
      },
    );

    // ── Fluxo de cancelamento ──────────────────────────────────────────────

    testWidgets(
      'DADO que o usuário não fez alterações '
      'QUANDO toca em "CANCELAR" '
      'ENTÃO deve fechar a tela sem exibir o bottom sheet',
      (tester) async {
        await tester.pumpWidget(_wrapWithNav());
        await tester.pump();

        await tester.tap(find.text('Abrir'));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('CANCELAR'));
        await tester.tap(find.text('CANCELAR'));
        await tester.pumpAndSettle();

        expect(find.text('Descartar alterações?'), findsNothing);
        expect(find.text('Editar perfil'), findsNothing);
      },
    );

    testWidgets(
      'DADO que o usuário fez alterações não salvas '
      'QUANDO toca em "CANCELAR" '
      'ENTÃO deve exibir o bottom sheet de confirmação',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).first, 'Novo Nome');
        await tester.pump();

        await _scrollTo(tester, find.text('CANCELAR'));
        await tester.tap(find.text('CANCELAR'));
        await tester.pumpAndSettle();

        expect(find.text('Descartar alterações?'), findsOneWidget);
        expect(find.text('CONTINUAR EDITANDO'), findsOneWidget);
        expect(find.text('DESCARTAR'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o bottom sheet de descarte está aberto '
      'QUANDO o usuário toca em "CONTINUAR EDITANDO" '
      'ENTÃO o sheet deve fechar e a tela de edição permanecer',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).first, 'Novo Nome');
        await tester.pump();

        await _scrollTo(tester, find.text('CANCELAR'));
        await tester.tap(find.text('CANCELAR'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('CONTINUAR EDITANDO'));
        await tester.pumpAndSettle();

        expect(find.text('Descartar alterações?'), findsNothing);
        expect(find.text('Editar perfil'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o bottom sheet de descarte está aberto '
      'QUANDO o usuário toca em "DESCARTAR" '
      'ENTÃO deve fechar a tela de edição',
      (tester) async {
        await tester.pumpWidget(_wrapWithNav());
        await tester.pump();

        await tester.tap(find.text('Abrir'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).first, 'Novo Nome');
        await tester.pump();

        await _scrollTo(tester, find.text('CANCELAR'));
        await tester.tap(find.text('CANCELAR'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('DESCARTAR'));
        await tester.pumpAndSettle();

        expect(find.text('Editar perfil'), findsNothing);
      },
    );

    // ── Toggle de visibilidade ─────────────────────────────────────────────

    testWidgets(
      'DADO que a tela está aberta '
      'QUANDO o usuário toca no ícone de olho no campo de senha '
      'ENTÃO deve alternar entre obscurecido e visível',
      (tester) async {
        await tester.pumpWidget(_wrapDirect());
        await tester.pumpAndSettle();

        // Rola até os campos de senha para os ícones ficarem visíveis
        await _scrollTo(tester, find.byType(TextFormField).at(2));

        expect(find.byIcon(Icons.visibility_outlined), findsWidgets);

        await tester.tap(find.byIcon(Icons.visibility_outlined).first);
        await tester.pump();

        expect(find.byIcon(Icons.visibility_off_outlined), findsWidgets);
      },
    );
  });
}