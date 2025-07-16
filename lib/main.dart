import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luve_wish/SplashScreen/SplashScreen.dart';



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
          home: const SplashScreen(),
        );
      },
    );
  }
}
