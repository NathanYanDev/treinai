import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:treinai/core/theme/app_theme.dart';
import 'package:treinai/presentation/pages/profile_screen.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: AppTheme.dark,
    home: child,
    routes: {
      '/login': (_) => const Scaffold(body: Text('Login')),
    },
  );
}

Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    100,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pump();
}

void main() {
  group('ProfileScreen', () {
    testWidgets(
      'DADO que o usuário acessa seu perfil '
      'QUANDO a tela é exibida '
      'ENTÃO deve mostrar o header "SUA CONTA" e título "Perfil"',
      (tester) async {
        await tester.pumpWidget(_wrap(const ProfileScreen()));
        await tester.pumpAndSettle();

        expect(find.text('SUA CONTA'), findsOneWidget);
        expect(find.text('Perfil'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o usuário acessa seu perfil '
      'QUANDO a tela é exibida '
      'ENTÃO deve exibir nome, email e avatar com inicial correta',
      (tester) async {
        await tester.pumpWidget(_wrap(const ProfileScreen()));
        await tester.pumpAndSettle();

        expect(find.text('João Silva'), findsOneWidget);
        expect(find.text('joao@email.com'), findsOneWidget);
        expect(find.text('J'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o perfil está exibido '
      'QUANDO a tela é renderizada '
      'ENTÃO deve listar os 4 itens do perfil de treino com seus valores',
      (tester) async {
        await tester.pumpWidget(_wrap(const ProfileScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('MEU PERFIL DE TREINO'));

        expect(find.text('MEU PERFIL DE TREINO'), findsOneWidget);
        expect(find.text('Objetivo'), findsOneWidget);
        expect(find.text('Ganhar massa'), findsOneWidget);
        expect(find.text('Local de treino'), findsOneWidget);
        expect(find.text('Academia completa'), findsOneWidget);
        expect(find.text('Frequência'), findsOneWidget);
        expect(find.text('4× semana'), findsOneWidget);
        expect(find.text('Nível'), findsOneWidget);
        expect(find.text('Intermediário'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o perfil está exibido '
      'QUANDO a tela é renderizada '
      'ENTÃO deve exibir a seção CONFIGURAÇÕES com Notificações e Sair da conta',
      (tester) async {
        await tester.pumpWidget(_wrap(const ProfileScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('CONFIGURAÇÕES'));

        expect(find.text('CONFIGURAÇÕES'), findsOneWidget);
        expect(find.text('Notificações'), findsOneWidget);
        expect(find.text('Sair da conta'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o usuário está no perfil '
      'QUANDO toca em "EDITAR" '
      'ENTÃO deve navegar para a EditProfileScreen',
      (tester) async {
        await tester.pumpWidget(_wrap(const ProfileScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('EDITAR'));
        await tester.tap(find.text('EDITAR'));
        await tester.pumpAndSettle();

        expect(find.text('Editar perfil'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o usuário está no perfil '
      'QUANDO toca em "Sair da conta" '
      'ENTÃO deve navegar para /login com o stack limpo',
      (tester) async {
        await tester.pumpWidget(_wrap(const ProfileScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('Sair da conta'));
        await tester.tap(find.text('Sair da conta'));
        await tester.pumpAndSettle();

        expect(find.text('Login'), findsOneWidget);
        expect(find.byType(BackButton), findsNothing);
      },
    );
  });
}