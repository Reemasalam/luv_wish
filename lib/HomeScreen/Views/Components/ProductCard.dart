import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardSym extends StatelessWidget {
  const ProductCardSym({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.mrp,
    this.discountPercent,
    this.onTap,
    this.onMoveToBag,
  });

  final String imageUrl;
  final String title;
  final double price;
  final double mrp;
  final int? discountPercent;
  final VoidCallback? onTap;
  final VoidCallback? onMoveToBag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
     
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 86,
                height: 86,
                color: const Color(0xFFF6ECFF),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Right Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Price + MRP + Discount
                  Row(
                    children: [
                      Text(
                        "₹${price.toStringAsFixed(0)}",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (mrp > price)
                        Text(
                          "₹${mrp.toStringAsFixed(0)}",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: const Color(0xFF9E9E9E),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(width: 10),
                      if (discountPercent != null && discountPercent! > 0)
                        Text(
                          "${discountPercent}% off",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: const Color(0xFF21A144),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Move to Bag Button
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: onMoveToBag,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBE0E5A),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: Text(
                        "Shop Now",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
