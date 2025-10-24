import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSummaryCard extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const OrderSummaryCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        
        border: Border.all(
          color: Color(0xffECECEC),
          width: 1.w,
        ),  
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildItem(
              title: items[i]['title'],
              qty: items[i]['qty'],
              price: items[i]['price'],
            ),
            if (i != items.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required int qty,
    required double price,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and price row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              '₹${price.toStringAsFixed(0)}',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Qty: $qty',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
