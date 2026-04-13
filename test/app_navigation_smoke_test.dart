import 'package:flutter_test/flutter_test.dart';

import 'package:treinai/main.dart';
import 'package:treinai/presentation/pages/login/login_page.dart';
import 'package:treinai/presentation/pages/splash_screen.dart';

void main() {
  testWidgets(
    'Splash exibe marca e após animação navega para Login',
    (tester) async {
      await tester.pumpWidget(const App());
      await tester.pump();

      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.textContaining('Trein'), findsWidgets);

      await tester.pump(const Duration(milliseconds: 2100));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    },
  );
}
