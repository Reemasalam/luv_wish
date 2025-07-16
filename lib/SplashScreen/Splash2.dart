import 'package:flutter/material.dart';
import 'package:luve_wish/SplashScreen/ProductScreen.dart';

class Splash2Screen extends StatelessWidget {
  const Splash2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/paste.png',
              height: 440,
              width: 638,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Choose Products",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Because your body deserves the best \n  naturally and lovingly",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
                color: Colors.black87,
              ),
            ),

            const Spacer(), // Push controls to bottom

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Prev
                  TextButton(
                    onPressed: () {
                      // TODO: Handle previous action
                    },
                    child: const Text(
                      "Prev",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Dot
                  Row(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == 0 ? 12 : 8,
                        height: index == 0 ? 12 : 8,
                        decoration: BoxDecoration(
                          color: index == 0 ? Colors.black : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),

                  // Next
                  TextButton(
                  onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProductScreen(),
    ),
  );
},

                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
