import '../models/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> login({required String email, required String password});
  Future<void> register({
    required String name,
    required String surname,
    required String login,
    required String email,
    required String password,
  });

  Future<AuthSession?> getCurrentSession();

  Future<void> logout();
}
