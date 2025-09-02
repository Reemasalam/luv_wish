import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final pincodeController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  Future<bool> submitProfile(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null || token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No token found. Please log in.")),
        );
        return false;
      }

      final response = await http.post(
        Uri.parse("$baseUrl/auth/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "postalCode": pincodeController.text.trim(),
          "address": addressController.text.trim(),
          "city": cityController.text.trim(),
          "state": stateController.text.trim(),
          "country": countryController.text.trim(),
        }),
      );

      debugPrint("📤 Profile API Response: ${response.statusCode} - ${response.body}");

      if ( response.statusCode == 201) {
        final data = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Profile saved successfully!")),
        );
        return true;
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error["message"] ?? "Failed to save profile")),
        );
        return false;
      }
    } catch (e, st) {
      debugPrint("❌ Profile API Error: $e\n$st");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }
}
