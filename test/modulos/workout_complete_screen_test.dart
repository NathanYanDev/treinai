import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:treinai/app_routes.dart';
import 'package:treinai/core/theme/app_theme.dart';
import 'package:treinai/presentation/pages/workout_complete_screen.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: AppTheme.dark,
    home: child,
    routes: {
      AppRoutes.workouts: (_) => const Scaffold(body: Text('Workouts')),
    },
  );
}

Future<void> _setLargeScreen(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200, // 👈 mais forte pra garantir
    scrollable: find.byType(Scrollable).first, // 👈 CORRETO
  );
  await tester.pumpAndSettle();
}

void main() {
  group('WorkoutCompleteScreen', () {
    testWidgets(
      'DADO que o treino foi concluído '
      'QUANDO a tela é exibida '
      'ENTÃO deve mostrar ícone, título e subtítulo',
      (tester) async {
        await _setLargeScreen(tester);
        await tester.pumpWidget(_wrap(const WorkoutCompleteScreen()));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.check_rounded), findsOneWidget);

        // Evita problema com emoji
        expect(find.textContaining('Treino concluído'), findsOneWidget);

        expect(
          find.textContaining('Você completou o Treino A hoje.'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'DADO que o treino foi concluído '
      'QUANDO a tela é exibida '
      'ENTÃO deve exibir os 4 cards de estatísticas',
      (tester) async {
        await _setLargeScreen(tester);
        await tester.pumpWidget(_wrap(const WorkoutCompleteScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.textContaining('8/8'));

        expect(find.text('8/8'), findsOneWidget);
        expect(find.text('52min'), findsOneWidget);
        expect(find.text('24'), findsOneWidget);
        expect(find.text('288'), findsOneWidget);

        expect(find.text('EXERCÍCIOS'), findsOneWidget);
        expect(find.text('DURAÇÃO'), findsOneWidget);
        expect(find.text('SÉRIES TOTAIS'), findsOneWidget);
        expect(find.text('REPS TOTAIS'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que o usuário tem sequência ativa '
      'QUANDO a tela é exibida '
      'ENTÃO deve mostrar o streak corretamente',
      (tester) async {
        await _setLargeScreen(tester);
        await tester.pumpWidget(_wrap(const WorkoutCompleteScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.textContaining('Sequência'));

        expect(find.textContaining('Sequência de 8 dias'), findsOneWidget);
        expect(find.textContaining('Novo recorde pessoal'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que a tela está exibida '
      'QUANDO o usuário toca em voltar '
      'ENTÃO deve navegar para /workouts',
      (tester) async {
        await _setLargeScreen(tester);
        await tester.pumpWidget(_wrap(const WorkoutCompleteScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('VOLTAR AO INÍCIO'));
        await tester.tap(find.text('VOLTAR AO INÍCIO'));
        await tester.pumpAndSettle();

        expect(find.text('Workouts'), findsOneWidget);
      },
    );

    testWidgets(
      'DADO que a tela está exibida '
      'QUANDO o usuário toca em ver histórico '
      'ENTÃO não deve quebrar a aplicação',
      (tester) async {
        await _setLargeScreen(tester);
        await tester.pumpWidget(_wrap(const WorkoutCompleteScreen()));
        await tester.pumpAndSettle();

        await _scrollTo(tester, find.text('VER HISTÓRICO'));
        await tester.tap(find.text('VER HISTÓRICO'));
        await tester.pump();

        // Apenas valida que a tela ainda existe
        expect(find.textContaining('Treino concluído'), findsOneWidget);
      },
    );
  });
}