class AuthSession {
  const AuthSession({
    required this.userId,
    required this.email,
    required this.token,
    required this.isFallbackToken,
    required this.updatedAt,
  });

  final String userId;
  final String email;
  final String token;
  final bool isFallbackToken;
  final DateTime updatedAt;
}
