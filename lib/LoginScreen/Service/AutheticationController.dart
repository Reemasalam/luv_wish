import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  /// LOGIN
  Future<bool> login(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data["success"] == true) {
        final token = data["data"]["access_token"];

        // Decode JWT to get expiry
        final parts = token.split('.');
        if (parts.length != 3) throw Exception("Invalid token format");
        final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
        );
        final expiry = payload["exp"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setInt("expiry", expiry);

        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Invalid credentials")),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }

  /// REGISTER
  Future<bool> register(BuildContext context) async {
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"), // replace with your full API base
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 201) &&
          data["success"] == true) {
        final token = data["data"]["access_token"];

        // Decode expiry from token
        final parts = token.split('.');
        if (parts.length != 3) throw Exception("Invalid token format");
        final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
        );
        final expiry = payload["exp"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setInt("expiry", expiry);

        return true;
      } else {
       String message;
if (data["message"] is List) {
  message = (data["message"] as List).join(", ");
} else {
  message = data["message"]?.toString() ?? "Registration failed";
}

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(message)),
);

        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }

  /// Check if token exists and not expired
  
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final expiry = prefs.getInt("expiry");

    if (token == null || expiry == null) return false;

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (expiry > now) {
      return true;
    } else {
      await prefs.remove("token");
      await prefs.remove("expiry");
      return false;
    }
  }

  /// Logout
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, "/login");
  }
}
