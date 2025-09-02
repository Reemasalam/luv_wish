import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luve_wish/HomeScreen/HomeScreen.dart';
import 'package:luve_wish/LoginScreen/LoginScreen.dart';
import 'package:luve_wish/SplashScreen/SplashScreen.dart';

String? accessToken;
String baseUrl = "http://31.97.41.249/v1";

void main() {
  runApp(const LoveWish());
}

class LoveWish extends StatelessWidget {
  const LoveWish({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Love Wish',
          // First go to splash → it decides login/home
          home: const SplashScreen(),
          getPages: [
            GetPage(name: "/login", page: () => const LoginScreen()),
           // GetPage(name: "/home", page: () => const HomeScreen()),
          ],
        );
      },
    );
  }
}
