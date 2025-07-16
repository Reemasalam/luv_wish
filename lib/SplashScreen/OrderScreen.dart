import 'package:flutter/material.dart';
import 'package:luve_wish/LoginScreen/LoginScreen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
                children: const [
                  Text(
                    '3/3',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              // Main Image
              Expanded(
                child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:80),
                    Image.asset(
                      'assets/order.png',
                      fit: BoxFit.contain,
                      width: 448,
                      height: 338, // Reduced height to make more room for text
                    ),
                    const SizedBox(height: 20), // Smaller gap than before
                     Text(
                "Get Your Order",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                ),
              ),
            
                    const SizedBox(height: 8), // Reduced gap
                    const Text(
                     " She believed in clean comfort so \n we delivered",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                         fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff263238),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Controls
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Prev
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Prev',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    // Dots
                    Row(
                      children: [
                        dot(isActive: false),
                        const SizedBox(width: 6),
                        dot(isActive: true),
                        const SizedBox(width: 6),
                        dot(isActive: false),
                      ],
                    ),

                    // Next
                    TextButton(
                      onPressed: () {
                        Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
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

  Widget dot({required bool isActive}) {
    return Container(
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.black : Colors.grey.shade400,
      ),
    );
  }
}
