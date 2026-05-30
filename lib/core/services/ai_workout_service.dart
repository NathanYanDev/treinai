import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/user_onboarding.dart';
import '../../domain/models/workout.dart';
import '../constants/ai_workout_prompt.dart';
import 'secure_storage_service.dart';

class AiWorkoutService {
  AiWorkoutService({SecureStorageService? secureStorage})
      : _secureStorage = secureStorage ?? SecureStorageService();

  static const _baseUrl =
      'https://mobile-ios-ia.zani0x03.eti.br/api/ai/chat';

  final SecureStorageService _secureStorage;

  /// Envia o perfil do onboarding + prompt e retorna treinos parseados.
  Future<List<Workout>> generateWorkoutPlan(UserOnboarding onboarding) async {
    final token = await _secureStorage.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Usuário não autenticado. Faça login novamente.');
    }

    final body = <String, dynamic>{
      'prompt': kAiWorkoutPlanPrompt,
      ...onboarding.toAiPayload(),
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Erro da IA (${response.statusCode}): ${response.body}',
      );
    }

    final raw = _extractResponseText(response.body);
    return _parseWorkouts(raw);
  }

  String _extractResponseText(String body) {
    if (body.trim().isEmpty) {
      throw Exception('Resposta vazia da IA.');
    }

    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        final text = decoded['response'] ??
            decoded['text'] ??
            decoded['message'] ??
            decoded['content'];
        if (text is String && text.trim().isNotEmpty) return text;
        if (decoded['workouts'] is List) return jsonEncode(decoded);
      }
      if (decoded is List) return jsonEncode({'workouts': decoded});
    } catch (_) {
      // Corpo já é texto livre (JSON ou markdown).
    }

    return body;
  }

  List<Workout> _parseWorkouts(String raw) {
    final json = _decodeJsonObject(raw);
    final list = json['workouts'] as List<dynamic>? ??
        (json['data'] is Map<String, dynamic>
            ? (json['data'] as Map<String, dynamic>)['workouts'] as List?
            : null);

    if (list == null || list.isEmpty) {
      throw Exception('A IA não retornou treinos no formato esperado.');
    }

    final now = DateTime.now();
    return list.asMap().entries.map((entry) {
      final item = entry.value as Map<String, dynamic>;
      final id = (item['id'] as String?)?.trim();
      final createdAtRaw = item['created_at'] as String?;

      return Workout(
        id: (id != null && id.isNotEmpty)
            ? id
            : 'workout_${now.millisecondsSinceEpoch}_${entry.key}',
        name: item['name'] as String? ?? 'Treino ${entry.key + 1}',
        description: item['description'] as String? ?? 'Treino personalizado',
        exercises: (item['exercises'] as List<dynamic>? ?? [])
            .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
            .toList(),
        durationMinutes: item['duration_minutes'] as int? ?? 60,
        createdAt: createdAtRaw != null
            ? DateTime.tryParse(createdAtRaw) ?? now
            : now,
      );
    }).toList();
  }

  Map<String, dynamic> _decodeJsonObject(String raw) {
    final trimmed = raw.trim();
    try {
      final decoded = jsonDecode(trimmed);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is List) return {'workouts': decoded};
    } catch (_) {
      // Tenta extrair bloco JSON de markdown.
    }

    final start = trimmed.indexOf('{');
    final end = trimmed.lastIndexOf('}');
    if (start >= 0 && end > start) {
      final slice = trimmed.substring(start, end + 1);
      final decoded = jsonDecode(slice);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is List) return {'workouts': decoded};
    }

    throw Exception('Não foi possível interpretar a resposta da IA.');
  }
}
