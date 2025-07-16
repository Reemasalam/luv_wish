import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/SplashScreen/StartScreen.dart';

void main() {
  runApp(const MaterialApp(home: ForgotPasswordScreen()));
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                "Forgot\npassword?",
                style: GoogleFonts.montserrat(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your email address",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "* We will send you a message to set or reset your new password",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Color(0xff676767),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const StartScreen(),
    ),
  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEB147D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
