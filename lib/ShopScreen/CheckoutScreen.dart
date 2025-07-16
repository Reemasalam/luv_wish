import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/ShopScreen/PayScreen.dart';
import 'package:luve_wish/ShopScreen/Views/OrderCard.dart';
import 'package:luve_wish/Src/AppButton.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Checkout",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Title
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 23),
                const SizedBox(width: 8),
                Text(
                  "Delivery Address",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Address Card
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 90,
                    width: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "Address :\n216 St Paul's Rd, London N1 2LL, UK\nContact : +44-784232",
                      style: GoogleFonts.montserrat(fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 90,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.add, size: 20, color: Colors.black),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Order List Title
            Text(
              "Order List",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            OrderCard(),
           

            const SizedBox(height: 60),

            // ⬇️ Moved "Check Out" button inside scroll view
            Center(
  child: AppButton(
    text: "Check Out",
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> PayScreen()));
    }, backgroundColor: Color(0xffF83758),
  ),
),


            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
