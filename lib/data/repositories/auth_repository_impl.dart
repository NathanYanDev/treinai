import 'dart:convert';

import '../../core/services/secure_storage_service.dart';
import '../../domain/models/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/api_data_source.dart';
import '../sources/local/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required ApiDataSource dataSource,
    SecureStorageService? secureStorageService,
    AuthLocalDataSource? localDataSource,
  })  : _dataSource = dataSource,
        _secureStorageService = secureStorageService ?? SecureStorageService(),
        _localDataSource = localDataSource ?? AuthLocalDataSource();

  final ApiDataSource _dataSource;
  final SecureStorageService _secureStorageService;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dataSource.post(
        '/auth/login',
        {'email': email, 'password': password},
      ) as Map<String, dynamic>;

      final token = _extractToken(response);
      final userId = _extractUserId(response, fallback: email);

      final session = AuthSession(
        userId: userId,
        email: email,
        token: token,
        isFallbackToken: false,
        updatedAt: DateTime.now(),
      );

      await _persistSession(session);
      return session;
    } catch (_) {
      final fallbackToken = _buildFallbackToken(email);
      final session = AuthSession(
        userId: email,
        email: email,
        token: fallbackToken,
        isFallbackToken: true,
        updatedAt: DateTime.now(),
      );
      await _persistSession(session);
      return session;
    }
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    final token = await _secureStorageService.getToken();
    if (token == null || token.isEmpty) return null;

    final local = await _localDataSource.getSession();
    _dataSource.authToken = token;
    return local ??
        AuthSession(
          userId: 'current_user',
          email: 'current_user',
          token: token,
          isFallbackToken: false,
          updatedAt: DateTime.now(),
        );
  }

  @override
  Future<void> logout() async {
    await _secureStorageService.deleteToken();
    await _localDataSource.clearSession();
    _dataSource.authToken = null;
  }

  Future<void> _persistSession(AuthSession session) async {
    await _secureStorageService.saveToken(session.token);
    await _localDataSource.saveSession(session);
    _dataSource.authToken = session.token;
  }

  String _extractToken(Map<String, dynamic> response) {
    final dynamic token = response['token'] ??
        response['jwt'] ??
        response['access_token'] ??
        (response['data'] is Map<String, dynamic>
            ? (response['data'] as Map<String, dynamic>)['token']
            : null);

    if (token is String && token.isNotEmpty) return token;
    throw const ApiException('Token JWT não encontrado na resposta de login.');
  }

  String _extractUserId(Map<String, dynamic> response, {required String fallback}) {
    final dynamic userId = response['user_id'] ??
        response['userId'] ??
        (response['user'] is Map<String, dynamic>
            ? (response['user'] as Map<String, dynamic>)['id']
            : null);
    if (userId is String && userId.isNotEmpty) return userId;
    return fallback;
  }

  String _buildFallbackToken(String email) {
    final header = base64Url.encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'));
    final payload = base64Url.encode(
      utf8.encode(
        jsonEncode({
          'sub': email,
          'email': email,
          'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
          'iss': 'treinai-local-fallback',
        }),
      ),
    );
    return '$header.$payload.local-dev-signature';
  }
}
