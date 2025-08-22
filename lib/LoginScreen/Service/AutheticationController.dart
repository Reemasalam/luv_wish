import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/main.dart' as AppConfig;

import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// Function to login user
  Future<Map<String, dynamic>> login(BuildContext context) async {
   final url = "${AppConfig.baseUrl}/auth/login";

    try {
      // 🔹 Debugging: Print request
      print("📤 Sending POST request to: $url");
      print("📤 Request Headers: {Content-Type: application/json}");
      print("📤 Request Body: ${jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      })}");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      // 🔹 Debugging: Print response
      print("📥 Response Status: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          String token = data["data"]["access_token"];
          Map<String, dynamic> user = data["data"]["user"];

          // 🔹 Debugging: Print success
          print("✅ Login Success!");
          print("🔑 Access Token: $token");
          print("👤 User Info: $user");

          // Save token locally
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);
          await prefs.setString("userId", user["id"]);
          await prefs.setString("userName", user["name"]);
          await prefs.setString("userEmail", user["email"]);

          print("💾 Token and User info saved in SharedPreferences.");

          return {"success": true, "user": user};
        } else {
          print("❌ Login failed: Invalid response format");
          return {"success": false, "message": "Invalid login response"};
        }
      } else {
        print("❌ Server error: ${response.statusCode}");
        return {
          "success": false,
          "message": "Server error: ${response.statusCode} → ${response.body}"
        };
      }
    } catch (e) {
      print("🔥 Exception occurred: $e");
      return {"success": false, "message": "Error: $e"};
    }
  }
}
