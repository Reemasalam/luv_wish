import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luve_wish/LoginScreen/ForgetScreen.dart';
import 'package:luve_wish/LoginScreen/SignUpScreen.dart';

void main() {
  runApp(const MaterialApp(home: LoginScreen()));
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Welcome",
                  style: GoogleFonts.montserrat(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Back",
                  style: GoogleFonts.montserrat(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 28),
                _buildInputField(
                  hintText: "Username or Email",
                  icon: Icons.person,
                ),
                const SizedBox(height: 31),
                _buildInputField(
                  hintText: "Password",
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                       Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ForgotPasswordScreen(),
    ),
  );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.poppins(
                        color: Colors.pink,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 317,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffEB147D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:40),
                Center(
                  child: Text(
                    "- OR Continue with -",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _SocialLoginButton(
                      icon: FontAwesomeIcons.google,
                      iconColor: Color(0xFFDB4437), // Google Red
                    ),
                    SizedBox(width: 20),
                    _SocialLoginButton(
                      icon: FontAwesomeIcons.apple,
                      iconColor: Colors.black, // Apple Black
                    ),
                    SizedBox(width: 20),
                    _SocialLoginButton(
                      icon: FontAwesomeIcons.facebookF,
                      iconColor: Color(0xFF1877F2), // Facebook Blue
                    ),
                  ],
                ),
                const SizedBox(height: 30),
             
Center(
  child: RichText(
    text: TextSpan(
      style: GoogleFonts.poppins(color: Colors.black),
      children: [
        const TextSpan(text: "Create An Account "),
        TextSpan(
          text: "Sign Up",
          style: const TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              );
            },
        ),
      ],
    ),
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xff676767),
        ),
        prefixIcon: Icon(icon),
        suffixIcon:
            isPassword ? const Icon(Icons.remove_red_eye_outlined) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const _SocialLoginButton({
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.pink, width: 2), // Always pink border
        ),
        child: IconButton(
          icon: Icon(icon, color: iconColor), // Brand-colored icon
          onPressed: () {},
        ),
      ),
    );
  }
}
