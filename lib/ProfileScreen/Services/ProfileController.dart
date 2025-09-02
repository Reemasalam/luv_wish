import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:luve_wish/main.dart';

class ProfileController {
  Future<Map<String, dynamic>?> fetchProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/auth/customer/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["data"];
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data["message"] ?? "Failed to fetch profile");
      }
    } catch (e) {
      throw Exception("Error fetching profile: $e");
    }
  }
}
