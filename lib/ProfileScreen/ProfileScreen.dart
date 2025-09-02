import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/ProfileScreen/Services/ProfileController.dart' show ProfileController;
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _controller = ProfileController();

  Map<String, dynamic>? profileData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        setState(() {
          isLoading = false;
          errorMessage = "No token found. Please log in.";
        });
        return;
      }

      final data = await _controller.fetchProfile(token);

      if (mounted) {
        setState(() {
          profileData = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final customer = profileData?["CustomerProfile"] as Map<String, dynamic>?;

    return Scaffold(
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
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.pink))
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : profileData == null
                  ? const Center(child: Text("No profile data found"))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: (customer?["profilePicture"] != null &&
                                      (customer?["profilePicture"] as String).isNotEmpty)
                                  ? NetworkImage(customer!["profilePicture"])
                                  : const AssetImage('assets/avatar.png') as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 24),

                          _label("Name"),
                          _info(customer?["name"] ?? "Not available"),

                          const SizedBox(height: 12),
                          _label("Email"),
                          _info(profileData?["email"] ?? "Not available"),

                          const SizedBox(height: 12),
                          _label("Phone"),
                          _info(customer?["phone"] ?? "Not available"),

                          const SizedBox(height: 12),
                          _label("Address"),
                          _info(customer?["address"] ?? "Not available"),

                          const SizedBox(height: 12),
                          _label("City"),
                          _info(customer?["city"] ?? "Not available"),

                          const SizedBox(height: 12),
                          _label("State"),
                          _info(customer?["state"] ?? "Not available"),

                          const SizedBox(height: 12),
                          _label("Postal Code"),
                          _info(customer?["postalCode"] ?? "Not available"),

                          const SizedBox(height: 12),
                          _label("Country"),
                          _info(customer?["country"] ?? "Not available"),
                        ],
                      ),
                    ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  Widget _info(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffC4C4C4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
