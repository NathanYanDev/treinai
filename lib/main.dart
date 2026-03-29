import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'presentation/bloc/onboarding_cubit.dart';
import 'presentation/pages/onboarding/onboarding_router.dart'; //rotas do onboarding
import 'presentation/pages/workout_complete_screen.dart'; //comclusão do treino
import 'presentation/pages/profile_screen.dart'; //tela sobre
import 'presentation/pages/login/login_page.dart'; // tela login

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreinAI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: BlocProvider(
        create: (_) => OnboardingCubit(),
        child: const LoginPage(),
      ),
    );
  }
}
