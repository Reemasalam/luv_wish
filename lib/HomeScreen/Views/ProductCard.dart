import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/periodkit.png",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),

          // Title + Qty Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Product Title
              Expanded(
                child: Text(
                  "Period kit + Pain relief patch Combo",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500,fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 12),

              // Quantity Controls
              Row(
                children: [
                  _qtyBtn("-", () {}),
                  _qtyDisplay("2"),
                  _qtyBtn("+", () {}),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Price + Add to wish in the same row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price & Strike Price (Vertical)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹2499",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹4999",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),

              // Add to wish button (Vertically centered)
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF83758),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Add to wish",style: TextStyle(fontFamily: 'NunitoSans',fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Stock
          Text(
            "5+ stock",
            style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Quantity Button
  Widget _qtyBtn(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
         
        ),
        child: Center(child: Text(text)),
      ),
    );
  }

  // Quantity Display
  Widget _qtyDisplay(String number) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
       
      ),
      child: Text(
        number,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
