 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/periodkit.png",
                          width: 130,
                          height: 125,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Product Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Period kit + Pain relief patch Combo",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  "Quantity : ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text("3",
                                      style:
                                          GoogleFonts.poppins(fontSize: 13)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Rating
                            Row(
                              children: [
                                Text("4.8",
                                    style: GoogleFonts.poppins(fontSize: 14)),
                                const SizedBox(width: 6),
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 16),
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 16),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Price and Discount
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffCACACA)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Rs.340.00",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "up to 33% off",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Rs.450.00",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Order (1) :",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      Text(
                        "Rs. 340.00",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );}}