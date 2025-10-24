import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luve_wish/MyOrder/Views/OrderCard.dart';


class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, child) => Scaffold(
        backgroundColor: Colors.grey.shade100,
      
        body: SafeArea(
          child: Column(
            children: [
              // Tab Filters
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['All', 'Processing', 'Shipped', 'Delivered']
                      .map((e) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: e == 'All'
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: ListView(
                  children: const [
                    OrderCard(
                      orderId: 'ORD-2024-1187',
                      date: 'Oct 2, 2025',
                      productName: 'Period kit + Pain relief patch Combo',
                      productImage: 'assets/periodkit.png',
                      quantity: 3,
                      price: 4999,
                      status: 'Shipped',
                      estimatedDelivery: 'Oct 9, 2025',
                      showTrackButton: true,
                    ),
                    OrderCard(
                      orderId: 'ORD-2024-1187',
                      date: 'Oct 2, 2025',
                      productName: 'Period kit + Pain relief patch Combo',
                      productImage: 'assets/periodkit.png',
                      quantity: 3,
                      price: 4999,
                      status: 'Delivered',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
