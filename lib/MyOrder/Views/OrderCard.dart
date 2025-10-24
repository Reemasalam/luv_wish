import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String productName;
  final String productImage;
  final int quantity;
  final double price;
  final String status;
  final String estimatedDelivery;

  final bool showTrackButton;

  const OrderCard({
    Key? key,
    required this.orderId,
    required this.date,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.price,
    required this.status,
    this.estimatedDelivery = '',
    this.showTrackButton = false,
  }) : super(key: key);

  Color getStatusColor() {
    if (status.toLowerCase() == 'shipped') return Colors.green.shade100;
    if (status.toLowerCase() == 'delivered') return Colors.green.shade100;
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Order ID + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: getStatusColor(),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            date,
            style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 12.h),
          // Product Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  productImage,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Qty: $quantity',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                '₹$price',
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(height: 12.h),
          // Estimated Delivery / Delivered Message
          if (status.toLowerCase() == 'shipped' && estimatedDelivery != '')
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_shipping, size: 16.sp, color: Colors.blue),
                  SizedBox(width: 4.w),
                  Text(
                    'Estimated Delivery: $estimatedDelivery',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp, color: Colors.blue.shade800),
                  ),
                ],
              ),
            ),
          if (status.toLowerCase() == 'delivered')
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16.sp, color: Colors.green),
                  SizedBox(width: 4.w),
                  Text(
                    'Delivered successfully',
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp, color: Colors.green.shade800),
                  ),
                ],
              ),
            ),
          SizedBox(height: 12.h),
          // Total + Track Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount\n₹$price',
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              if (showTrackButton)
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA51058),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                  ),
                  icon: Icon(Icons.local_shipping, size: 16.sp,color: Colors.white,),
                  label: Text(
                    'Track Order',
                    style: GoogleFonts.poppins(fontSize: 12.sp,color: Colors.white),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
