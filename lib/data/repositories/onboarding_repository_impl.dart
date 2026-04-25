import '../../domain/models/user_onboarding.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../sources/api_data_source.dart';
import '../sources/local/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl({
    required this.dataSource,
    OnboardingLocalDataSource? localDataSource,
  }) : _localDataSource = localDataSource ?? OnboardingLocalDataSource();

  final ApiDataSource dataSource;
  final OnboardingLocalDataSource _localDataSource;

  @override
  Future<UserOnboarding?> getOnboarding(String userId) async {
    try {
      final json = await dataSource.get('/onboarding/$userId')
          as Map<String, dynamic>;
      final remote = UserOnboarding.fromJson(json);
      await _localDataSource.saveOnboarding(remote);
      return remote;
    } on ApiException catch (e) {
      if (e.statusCode == 404) {
        return _localDataSource.getOnboarding(userId);
      }
      return _localDataSource.getOnboarding(userId);
    } catch (_) {
      return _localDataSource.getOnboarding(userId);
    }
  }

  @override
  Future<UserOnboarding> saveOnboarding(UserOnboarding onboarding) async {
    try {
      final json = await dataSource.post(
        '/onboarding',
        onboarding.toJson(),
      ) as Map<String, dynamic>;
      final remote = UserOnboarding.fromJson(json);
      await _localDataSource.saveOnboarding(remote);
      return remote;
    } catch (_) {
      await _localDataSource.saveOnboarding(onboarding);
      return onboarding;
    }
  }
}
