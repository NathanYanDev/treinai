// import 'dart:convert';
// import 'package:http/http.dart' as http;

// abstract class IAuthService {
//   Future<AuthResponseDto> login(String username, String password);
// }

// class AuthService implements IAuthService {
//   final String baseUrl = "https://mobile-ios-login.zani0x03.eti.br/api/auth/login";
//   final String sistemaId = "393e9f12-069f-4fb2-b49b-fa5d48db3f7d";

// @override
//   Future<AuthResponseDto> login(String username, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "username": username,
//           "password": password,
//           "sistemaId": sistemaId,
//         }),
//       );

//       if (response.statusCode == 200) {
//         return AuthResponseDto.fromJson(jsonDecode(response.body));
//       } else {
//         throw Exception("Credenciais inválidas ou erro no servidor.");
//       }
//     } catch (e) {
//       throw Exception("Erro ao conectar na API: $e");
//     }
//   }
// }
