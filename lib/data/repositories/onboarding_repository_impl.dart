import '../../domain/models/user_onboarding.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../sources/api_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl({required this.dataSource});

  final ApiDataSource dataSource;

  @override
  Future<UserOnboarding?> getOnboarding(String userId) async {
    try {
      final json = await dataSource.get('/onboarding/$userId')
          as Map<String, dynamic>;
      return UserOnboarding.fromJson(json);
    } on ApiException catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }

  @override
  Future<UserOnboarding> saveOnboarding(UserOnboarding onboarding) async {
    final json = await dataSource.post(
      '/onboarding',
      onboarding.toJson(),
    ) as Map<String, dynamic>;
    return UserOnboarding.fromJson(json);
  }
}
