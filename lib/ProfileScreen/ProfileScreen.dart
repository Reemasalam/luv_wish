import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.black),
  onPressed: () {
    Navigator.pop(context); // Navigates back to the previous screen
  },
),
        title: Text(
          'Profile Screen',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, size: 16, color: Colors.pink),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Personal Details
            Text(
              "Personal Details",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),

            _label("Email Address"),SizedBox(height: 10),
            _inputField("Enter your email",),

            const SizedBox(height: 12),
            _label("Password"),SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "********",
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
               enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffC4C4C4), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffC4C4C4), width: 2),
      ),
                suffix: Text(
                  "Change Password",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),

            // Section: Delivery Address
            Text(
              "Delivery Address Details",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            _label("Pincode"),SizedBox(height: 10),
            _inputField("Enter pincode"),

            const SizedBox(height: 12),
            _label("Address"),SizedBox(height: 10),
            _inputField("Enter full address"),

            const SizedBox(height: 12),
            _label("City"),SizedBox(height: 10),
            _inputField("Enter city name",),

            const SizedBox(height: 12),
            _label("State"),SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: "N1 2LL",
              decoration: InputDecoration(
                hintText: "Select state",
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffC4C4C4), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffC4C4C4), width: 2),
      ),
              ),
              items: ["N1 2LL", "W1A 1AA", "SW1A 0AA"]
                  .map((state) => DropdownMenuItem(
                        value: state,
                        child: Text(state),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),

            const SizedBox(height: 12),
            _label("Country"),SizedBox(height: 10),
            _inputField("Enter country name"),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),

            // Section: Bank Details
            RichText(
              text: TextSpan(
                text: "Bank Account Details ",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: "(Optional)",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _label("Bank Account Number"),SizedBox(height: 10),
            _inputField("Enter account number", ),

            const SizedBox(height: 12),SizedBox(height: 10),
            _label("Account Holder's Name"),
            _inputField("Enter name",),

            const SizedBox(height: 12),
            _label("IFSC Code"),SizedBox(height: 10),
            _inputField("Enter IFSC code"),

            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF83758),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  "Save",
                  style: GoogleFonts.montserrat(
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
    );
  }

  // Helper: Label widget
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

  // Helper: Input Field
 Widget _inputField(String hint) {
  return TextField(
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffC4C4C4), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffC4C4C4), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    ),
  );
}

}
