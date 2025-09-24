import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/LoginScreen/Model/CustomerProfile.dart';
import 'package:luve_wish/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  /// Fetch Profile
  Future<CustomerProfile?> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      return null;
    }

    final url = Uri.parse('$baseUrl/auth/customer/profile');
    

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["data"] != null) {
          return CustomerProfile.fromJson(data["data"]);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Update Profile

Future<bool> submitProfile(
  BuildContext context, {
  required String name,
  required String phone,
  required String address,
  required String city,
  required String state,
  required String postalCode,
  required String country,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');

  if (accessToken == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Authentication required. Please login again.')),
    );
    return false;
  }

  final url = Uri.parse('$baseUrl/auth/profile');

  final body = {
    "name": name.trim(),
    "phone": phone.trim(),
    "address": address.trim(),
    "city": city.trim(),
    "state": state.trim(),
    "postalCode": postalCode.trim(),
    "country": country.trim(),
  };

  // 🐞 Debug logs
  debugPrint("🔑 Access Token: $accessToken");
  debugPrint("📤 API URL: $url");
  debugPrint("📦 Payload: ${jsonEncode(body)}");

  try {
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );

    debugPrint("📥 Response [${response.statusCode}]: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed: ${response.body}')),
      );
      return false;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
    return false;
  }
}
}
