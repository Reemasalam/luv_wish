import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/LoginScreen/Service/ProfileController.dart';
import '/LoginScreen/LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final ProfileController controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text(
              "Skip",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Details",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              _buildField(label: "Full Name", controller: controller.nameController),
              const SizedBox(height: 16),
              _buildField(label: "Phone Number", controller: controller.phoneController),
              const SizedBox(height: 16),
              _buildField(label: "Pincode", controller: controller.pincodeController),
              const SizedBox(height: 16),
              _buildField(label: "Address", controller: controller.addressController),
              const SizedBox(height: 16),
              _buildField(label: "City", controller: controller.cityController),
              const SizedBox(height: 16),
              _buildField(label: "State", controller: controller.stateController),
              const SizedBox(height: 16),
              _buildField(label: "Country", controller: controller.countryController),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await controller.submitProfile(
                      context,
                      name: controller.nameController.text,           // ✅ Fixed
                      phone: controller.phoneController.text,         // ✅ Fixed
                      address: controller.addressController.text,     // ✅ Fixed
                      city: controller.cityController.text,           // ✅ Fixed
                      state: controller.stateController.text,         // ✅ Fixed
                      postalCode: controller.pincodeController.text,  // ✅ Fixed
                      country: controller.countryController.text,     // ✅ Fixed
                    );
                    if (success && context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintText: "Enter $label",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF676767),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFE91E63),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
