// ProfileScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/LoginScreen/Model/CustomerProfile.dart';
import 'package:luve_wish/LoginScreen/Service/ProfileController.dart';
import 'package:luve_wish/LoginScreen/LoginScreen.dart';
import 'package:luve_wish/Wishlist/Service/WishlistController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _controller = ProfileController();
  final wishlistController = Get.put(WishlistController());

  CustomerProfile? profile;
  bool isLoading = true;
  String? errorMessage;
  String? token;

  // Single source of truth for inputs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    pincodeController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString("access_token");

      if (savedToken == null) {
        setState(() {
          isLoading = false;
          errorMessage = "No token found. Please log in.";
        });
        return;
      }

      token = savedToken;
      final data = await _controller.fetchProfile();

      if (!mounted) return;

      setState(() {
        profile = data;
        isLoading = false;
        if (profile == null) {
          errorMessage = "Failed to load profile.";
        } else {
          emailController.text = profile!.email;
          passwordController.text = "********";
          pincodeController.text = profile!.profile.postalCode;
          addressController.text = profile!.profile.address;
          cityController.text = profile!.profile.city;
          stateController.text = profile!.profile.state;
          countryController.text = profile!.profile.country;
          nameController.text = profile!.profile.name;
          phoneController.text = profile!.profile.phone;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  String _getInitials(String fullName) {
    if (fullName.isEmpty) return "";
    final names = fullName.split(" ");
    String initials = "";
    if (names.isNotEmpty && names.first.isNotEmpty) initials += names.first[0];
    if (names.length > 1 && names.last.isNotEmpty) initials += names.last[0];
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Profile',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _logout,
            child: const Text(
              "Log out",
              style: TextStyle(color: Colors.pink),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.pink))
            : errorMessage != null
                ? Center(child: Text(errorMessage!))
                : profile == null
                    ? const Center(child: Text("No profile data found"))
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.pink,
                                        child: Text(
                                          _getInitials(nameController.text.isNotEmpty
                                              ? nameController.text
                                              : profile!.profile.name),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.pink,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    _sectionTitle("Personal Details"),
                                    const SizedBox(height: 8),
                                    _textField("Email Address", emailController),
                                    const SizedBox(height: 12),
                                    _textField("Password", passwordController, obscureText: true),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Change Password",
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _sectionTitle("Delivery Address Details"),
                                    const SizedBox(height: 8),
                                    _textField("Name", nameController),
                                    const SizedBox(height: 12),
                                    _textField("Phone Number", phoneController),
                                    const SizedBox(height: 12),
                                    _textField("Pincode", pincodeController),
                                    const SizedBox(height: 12),
                                    _textField("Address", addressController),
                                    const SizedBox(height: 12),
                                    _textField("City", cityController),
                                    const SizedBox(height: 12),
                                    _textField("State", stateController),
                                    const SizedBox(height: 12),
                                    _textField("Country", countryController),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.pink,
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await _controller.submitProfile(
                                            context,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            address: addressController.text,
                                            city: cityController.text,
                                            state: stateController.text,
                                            postalCode: pincodeController.text,
                                            country: countryController.text,
                                          );
                                        },
                                        child: const Text("Save"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
