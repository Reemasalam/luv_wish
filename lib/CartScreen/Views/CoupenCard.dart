import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:luve_wish/CartScreen/Model/CoupenModel.dart';


class CouponCard extends StatelessWidget {
  final List<Coupon> coupons;
  final void Function(Coupon)? onApply; // callback when user taps apply

  const CouponCard({
    super.key,
    required this.coupons,
    this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Row(
          children: [
            const Icon(Icons.local_offer_outlined, size: 18),
            const SizedBox(width: 6),
            Text(
              'Apply Coupon',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        children: coupons.map((coupon) {
          final dateFormatter = DateFormat('dd MMM yyyy');
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 6, bottom: 4),
            decoration: BoxDecoration(
              color: const Color(0xffFDF2F8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coupon name / title
                Text(
                  coupon.couponName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),

                // Description dynamically built from model
                Text(
                  _buildCouponDescription(coupon),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),

                // Validity dates
                Text(
                  "Valid till: ${dateFormatter.format(coupon.validTill)}",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 10),

                // Code & button row
                Row(
                  children: [
                  //  Container(
                    //  width: 110,
                      //height: 28,
                    //  decoration: BoxDecoration(
                      //  color: Colors.white,
                        //borderRadius: BorderRadius.circular(8),
                    //    border: Border.all(color: Colors.grey.shade300),
                      //),
                    ////  alignment: Alignment.center,
                   //   child: Text(
                     //   coupon.id, // or coupon.couponName if that’s your coupon code
                       // textAlign: TextAlign.center,
                      //  style: GoogleFonts.poppins(
                        //  fontSize: 12,
                         // fontWeight: FontWeight.w500,
                          //color: Colors.black87,
                      // ),
                     // ),
                   // ),
                    const Spacer(),
                    SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () => onApply?.call(coupon),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffA51058),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Apply Coupon',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Helper method to dynamically describe each coupon
  String _buildCouponDescription(Coupon coupon) {
    String valueText = coupon.valueType.toLowerCase() == "percent"
        ? "${coupon.value}% off"
        : "₹${coupon.value} off";

    return "$valueText on minimum spend of ₹${coupon.minimumSpent}";
  }
}
