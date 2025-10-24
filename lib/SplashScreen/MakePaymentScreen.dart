import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luve_wish/LoginScreen/LoginScreen.dart';
import 'package:luve_wish/SplashScreen/OrderScreen.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Top Row: Progress + Skip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '2/3',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => const LoginScreen());
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              // Main Image + Texts
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Image.asset(
                        'assets/payment.png',
                        fit: BoxFit.contain,
                        width: 288.w,
                        height: 242.h,
                      ),
                    ),
                    SizedBox(height: 60.h),
                    const Text(
                      "Make Payment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'poppins',
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'No more awkward shelves. Shop in \n confidence',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff26323899),
                      ),
                    ),
                  ],
                ),
              ),

              // Dots + Next Button
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    // Page Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dot(isActive: false), // 1st dot
                        const SizedBox(width: 6),
                        dot(isActive: true),  // 2nd dot (active)
                        const SizedBox(width: 6),
                        dot(isActive: false), // 3rd dot
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Next Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffC61469),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => const OrderScreen());
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable dot widget
  Widget dot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 14 : 8, // Larger width for active dot
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive ? Colors.black : Colors.grey.shade400,
      ),
    );
  }
}
