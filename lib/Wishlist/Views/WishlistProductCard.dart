import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/Wishlist/Model/WishlistProductModel.dart';

class WishlistProductCard extends StatelessWidget {
  final WishlistProduct wishlistItem;
  final VoidCallback onBuyNow;
  final VoidCallback onDelete;

  const WishlistProductCard({
    super.key,
    required this.wishlistItem,
    required this.onBuyNow,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final product = wishlistItem.product;

    if (product == null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(child: Text("Product not available")),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Placeholder
          Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: const Icon(Icons.image, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // Product Name
          Text(
            product.name,
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 4),

          // Price
          Row(
            children: [
              Text(
                "\$${product.actualPrice.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "\$${product.discountedPrice.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 8),

         // Stock count + Buttons Row
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Stock count
    Text(
      "Stock: ${product.stockCount}",
      style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
    ),

    
        // Buy Now Button
        ElevatedButton.icon(
          onPressed: onBuyNow,
          icon: Image.asset(
            "assets/fi.png",
            height: 16,
            color: Colors.white,
          ),
          label: const Text(
            "Buy Now",
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color(0xff4AD082)),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),

        // Smaller spacing
        const SizedBox(width: 4),

        // Delete Icon moved slightly to left
        GestureDetector(
          onTap: onDelete,
          child: const Icon(
            Icons.delete_outline_outlined,
            size: 24,
            color: Color(0xff292D32),
          ),
        ),
      ],
    ),
  ],
),



    );
  }
}
