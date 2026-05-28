import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/services/secure_storage_service.dart';

class ChatService {
  final String baseUrl = "https://mobile-ios-ia.zani0x03.eti.br/api/ai/chat";
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<String> sendMessage(String prompt) async {
    try {
      final token = await _secureStorage.getToken();

      if (token == null) {
        throw Exception("Usuário não autenticado. Faça login novamente.");
      }

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);

        return data['response'] ??
            data['text'] ??
            "Resposta gerada com sucesso.";
      } else {
        throw Exception("Erro da IA: \${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erro ao conectar com a IA: \$e");
    }
  }
}
