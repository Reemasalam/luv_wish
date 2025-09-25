import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luve_wish/LoginScreen/ForgetScreen.dart';
import 'package:luve_wish/LoginScreen/LoginScreen.dart';
import 'package:luve_wish/LoginScreen/RegisterScreen.dart';
import 'package:luve_wish/LoginScreen/Service/AutheticationController.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  // ✅ Observables for password visibility
  final RxBool _obscurePassword = true.obs;
  final RxBool _obscureConfirmPassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Text("Create an",
                    style: GoogleFonts.montserrat(
                        fontSize: 36, fontWeight: FontWeight.w600)),
                Text("Account",
                    style: GoogleFonts.montserrat(
                        fontSize: 36, fontWeight: FontWeight.w600)),
                const SizedBox(height: 30),

                // Email / Username
                _buildInputField(
                  hintText: "Username or Email",
                  icon: Icons.email,
                  controller: controller.emailController,
                ),
                const SizedBox(height: 20),

                // Password
                Obx(() => _buildInputField(
                      hintText: "Password",
                      icon: Icons.lock,
                      controller: controller.passwordController,
                      isPassword: true,
                      obscureText: _obscurePassword.value,
                      onToggle: () =>
                          _obscurePassword.value = !_obscurePassword.value,
                    )),
                const SizedBox(height: 20),

                // Confirm Password
                Obx(() => _buildInputField(
                      hintText: "Confirm Password",
                      icon: Icons.lock,
                      controller: controller.confirmPasswordController,
                      isPassword: true,
                      obscureText: _obscureConfirmPassword.value,
                      onToggle: () => _obscureConfirmPassword.value =
                          !_obscureConfirmPassword.value,
                    )),
                const SizedBox(height: 20),

                // Terms & Register Notice
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff676767),
                    ),
                    children: [
                      const TextSpan(text: "By clicking the "),
                      TextSpan(
                        text: "Register",
                        style: const TextStyle(color: Colors.red),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(
                          text: " button, you agree\nto the public offer"),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 317,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await controller.register(context);
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffEB147D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Create Account",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "- OR Continue with -",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),

                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _SocialLoginButton(
                      icon: FontAwesomeIcons.google,
                      iconColor: Color(0xFFDB4437),
                    ),
                    SizedBox(width: 20),
                    _SocialLoginButton(
                      icon: FontAwesomeIcons.apple,
                      iconColor: Colors.black,
                    ),
                    SizedBox(width: 20),
                    _SocialLoginButton(
                      icon: FontAwesomeIcons.facebookF,
                      iconColor: Color(0xFF1877F2),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Login Link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(color: Colors.black),
                      children: [
                        const TextSpan(text: "I Already have an Account "),
                        TextSpan(
                          text: "Login",
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
                                  builder: (context) => const LoginScreen(),
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
    required TextEditingController controller,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xff676767),
        ),
        prefixIcon: Icon(icon),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: onToggle,
              )
            : null,
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
          border: Border.all(color: Colors.pink, width: 2),
        ),
        child: IconButton(
          icon: Icon(icon, color: iconColor),
          onPressed: () {},
        ),
      ),
    );
  }
}
