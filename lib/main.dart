import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'data/repositories/workout_repository_impl.dart';
import 'data/sources/api_data_source.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'domain/repositories/workout_repository.dart';
import 'presentation/pages/ai_generating_screen.dart';
import 'presentation/pages/edit_profile_screen.dart';
import 'presentation/pages/login/login_page.dart';
import 'presentation/pages/onboarding/onboarding_flow_screen.dart';
import 'presentation/pages/profile_screen.dart';
import 'presentation/pages/register_page.dart';
import 'presentation/pages/splash_screen.dart';
import 'presentation/pages/workout_complete_args.dart';
import 'presentation/pages/workout_complete_screen.dart';
import 'presentation/pages/workout_detail_screen.dart';
import 'presentation/pages/workout_execution_screen.dart';
import 'presentation/pages/workout_list_screen.dart';

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
      child: MaterialApp(
        title: 'TreinAI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.workoutDetail:
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => WorkoutDetailScreen(
                  template: WorkoutDetailScreen.resolveArgs(settings.arguments),
                ),
              );
            case AppRoutes.workoutExecution:
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => WorkoutExecutionScreen(
                  template: WorkoutExecutionScreen.resolveArgs(settings.arguments),
                ),
              );
            case AppRoutes.workoutComplete:
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => WorkoutCompleteScreen(
                  args: settings.arguments as WorkoutCompleteArgs?,
                ),
              );
            default:
              return null;
          }
        },
        routes: {
          AppRoutes.splash: (_) => const SplashScreen(),
          AppRoutes.login: (_) => const LoginPage(),
          AppRoutes.register: (_) => const RegisterPage(),
          AppRoutes.onboarding: (_) => const OnboardingFlowScreen(),
          AppRoutes.aiLoading: (_) => const AiGeneratingScreen(),
          AppRoutes.workouts: (_) => const WorkoutListScreen(),
          AppRoutes.profile: (_) => const ProfileScreen(),
          AppRoutes.editProfile: (_) => const EditProfileScreen(),
        },
      ),
    );
  }
}
