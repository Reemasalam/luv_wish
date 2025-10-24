import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/HomeScreen/HomeScreen.dart';
import 'package:luve_wish/LoginScreen/LoginScreen.dart';
import 'package:luve_wish/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final isLoading = false.obs;
  final token = ''.obs;

  Timer? _autoLogoutTimer;

  /// LOGIN
  Future<bool> login(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {
          'Content-Type': 'application/json',
           'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data["success"] == true) {
        final tokenValue = data["data"]["access_token"];

        // Decode expiry (if JWT)
        DateTime? expiryDate = _decodeExpiryFromJwt(tokenValue);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", tokenValue);
        if (expiryDate != null) {
          await prefs.setInt("expiry", expiryDate.millisecondsSinceEpoch);
        }

        token.value = tokenValue;
        accessToken = tokenValue;

        print("✅ Token saved successfully");

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
        Uri.parse("$baseUrl/auth/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 201) && data["success"] == true) {
        final tokenValue = data["data"]["access_token"];
        DateTime? expiryDate = _decodeExpiryFromJwt(tokenValue);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", tokenValue);
        if (expiryDate != null) {
          await prefs.setInt("expiry", expiryDate.millisecondsSinceEpoch);
        }

        token.value = tokenValue;
        accessToken = tokenValue;

        print("✅ Token saved successfully");

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

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");
    final expiryMillis = prefs.getInt("expiry");

    if (token == null) return false;

    if (expiryMillis != null) {
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiryMillis);
      return expiryDate.isAfter(DateTime.now());
    }

    return true; // If no expiry, assume valid
  }

  /// Logout
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, "/login");
  }

  DateTime? _decodeExpiryFromJwt(String jwt) {
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return null;

      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final payloadMap = json.decode(payload);
      final exp = payloadMap['exp'];

      if (exp != null) {
        return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      }
    } catch (e) {
      print("Failed to decode token expiry: $e");
    }
    return null;
  }

  void scheduleAutoLogout(DateTime expiryTime) {
    _autoLogoutTimer?.cancel();
    final duration = expiryTime.difference(DateTime.now());

    if (duration.isNegative) {
      logoutAdmin();
    } else {
      _autoLogoutTimer = Timer(duration, () => logoutAdmin());
    }
  }

  Future<void> logoutAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token.value = '';
    _autoLogoutTimer?.cancel();

    Fluttertoast.showToast(
      msg: "You have been logged out.",
    );
    Get.offAll(() => const LoginScreen());
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('access_token');
    final expiryMillis = prefs.getInt('expiry');

    if (savedToken == null) {
      Get.offAll(() => const LoginScreen());
      return;
    }

    if (expiryMillis != null) {
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiryMillis);

      if (expiryDate.isAfter(DateTime.now())) {
        token.value = savedToken;
        accessToken = savedToken;
        scheduleAutoLogout(expiryDate);
        Get.offAll(() => const HomeScreen());
      } else {
        await logoutAdmin();
      }
    } else {
      // No expiry stored → assume valid
      token.value = savedToken;
      accessToken = savedToken;
      Get.offAll(() => const HomeScreen());
    }
  }
}
