import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luve_wish/HomeScreen/HomeScreen.dart';
import 'package:luve_wish/SplashScreen/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:luve_wish/LoginScreen/Service/AutheticationController.dart';
import 'dart:convert';

String? accessToken;
String baseUrl = "http://31.97.41.249/v1";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register controller with GetX
  final loginController = Get.put(LoginController());

  final prefs = await SharedPreferences.getInstance();
  accessToken = prefs.getString('access_token');

  Widget initialScreen;

  if (accessToken != null && !_isTokenExpired(accessToken!)) {
    // ✅ Token is valid
    loginController.token.value = accessToken!;

    // Decode expiry & schedule auto logout
    final expiry = _getTokenExpiry(accessToken!);
    if (expiry != null) {
      loginController.scheduleAutoLogout(expiry);
    }

    initialScreen = const HomeScreen();
  } else {
    // ❌ Token invalid or expired
    initialScreen = const SplashScreen();
  }

  runApp(LoveWish(initialHome: initialScreen));
}

/// 🔹 Token validation helpers
bool _isTokenExpired(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) {
      // Not a JWT → assume valid until server rejects
      return false;
    }

    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final payloadMap = json.decode(payload);

    final exp = payloadMap['exp'];
    if (exp == null) return false; // no expiry → treat as valid

    final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return DateTime.now().isAfter(expiryDate);
  } catch (e) {
    print("❌ Token decoding failed: $e");
    return false; // safer fallback
  }
}

DateTime? _getTokenExpiry(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final payloadMap = json.decode(payload);

    final exp = payloadMap['exp'];
    if (exp == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  } catch (_) {
    return null;
  }
}

/// 🔹 App Widget
class LoveWish extends StatelessWidget {
  final Widget initialHome;
  const LoveWish({super.key, required this.initialHome});

  @override
  Widget build(BuildContext context) { 
    return ScreenUtilInit(
      designSize: const Size(400, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => GetMaterialApp( 
        
        debugShowCheckedModeBanner: false,
        home: initialHome,
      ),
    );
  }
}
