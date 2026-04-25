import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'data/sources/api_data_source.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'data/repositories/workout_repository_impl.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'domain/repositories/workout_repository.dart';
import 'presentation/bloc/onboarding_cubit.dart';
import 'presentation/pages/onboarding/onboarding_router.dart';
import 'presentation/pages/workout_complete_screen.dart';
import 'presentation/pages/profile_screen.dart';
import 'presentation/pages/login/login_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final apiDataSource = ApiDataSource(
      baseUrl: 'https://api.treinai.com.br/v1',
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardingRepository>(
          create: (_) =>
              OnboardingRepositoryImpl(dataSource: apiDataSource),
        ),
        RepositoryProvider<WorkoutRepository>(
          create: (_) =>
              WorkoutRepositoryImpl(dataSource: apiDataSource),
        ),
      ],
      child: BlocProvider(
        create: (context) => OnboardingCubit(
          repository: context.read<OnboardingRepository>(),
        ),
        child: MaterialApp(
          title: 'TreinAI',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          home: const LoginPage(),
        ),
      ),
    );
  }
}
