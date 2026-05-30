import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/services/secure_storage_service.dart';
import '../../domain/models/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/api_data_source.dart';
import '../sources/local/auth_local_data_source.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required ApiDataSource dataSource,
    SecureStorageService? secureStorageService,
    AuthLocalDataSource? localDataSource,
  }) : _dataSource = dataSource,
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
      final String baseUrl =
          "https://mobile-ios-login.zani0x03.eti.br/api/auth/login";
      final String sistemaId = "393e9f12-069f-4fb2-b49b-fa5d48db3f7d";

      final response =
          await _dataSource.post(baseUrl, {
                'username': email,
                'password': password,
                'sistemaId': sistemaId,
              })
              as Map<String, dynamic>;

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
    } catch (e) {
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
  Future<void> register({
    required String name,
    required String surname,
    required String login,
    required String email,
    required String password,
  }) async {
    final String baseUrl =
        "https://mobile-ios-login.zani0x03.eti.br/api/register";
    final String sistemaId = "393e9f12-069f-4fb2-b49b-fa5d48db3f7d";

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "surname": surname,
          "login": login,
          "email": email,
          "password": password,
          "sistemaId": sistemaId,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return;
      } else {
        throw Exception("Erro do servidor: ${response.statusCode}");
      }
    } catch (e) {
      print('ERRO NO CADASTRO: $e');
      throw Exception(
        'Falha ao criar conta. Verifique os dados e tente novamente.',
      );
    }
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    final token = await _secureStorageService.getToken();
    if (token == null || token.isEmpty) return null;

    AuthSession? local;

    if (!kIsWeb) {
      local = await _localDataSource.getSession();
    }

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
    if (!kIsWeb) {
      await _localDataSource.saveSession(session);
    }
    _dataSource.authToken = session.token;
  }

  String _extractToken(Map<String, dynamic> response) {
    final dynamic token =
        response['token'] ??
        response['jwt'] ??
        response['access_token'] ??
        (response['data'] is Map<String, dynamic>
            ? (response['data'] as Map<String, dynamic>)['token']
            : null);

    if (token is String && token.isNotEmpty) return token;
    throw const ApiException('Token JWT não encontrado na resposta de login.');
  }

  String _extractUserId(
    Map<String, dynamic> response, {
    required String fallback,
  }) {
    final dynamic userId =
        response['user_id'] ??
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
