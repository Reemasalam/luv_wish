import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/CartScreen/AddressFormScreen.dart';
import 'package:luve_wish/CartScreen/Services/CartController.dart';

import 'package:luve_wish/CartScreen/Services/CheckoutController.dart';
import 'package:luve_wish/CartScreen/Views/CartProductCard.dart';
import 'package:luve_wish/CartScreen/Views/CoupenCard.dart';
import 'package:luve_wish/CartScreen/Model/AddressModel.dart';
import 'package:luve_wish/CartScreen/Views/OrderItemCard.dart';
import 'package:luve_wish/CartScreen/Views/UpiPaymentCard.dart';

class OrderConfirmationScreen extends StatelessWidget {
  OrderConfirmationScreen({super.key});

  final CheckoutController controller = Get.put(CheckoutController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    // Fetch addresses & cart on screen open
  

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Image.asset('assets/logo.png', height: 23, fit: BoxFit.contain),
      ),
      body: Obx(() {
        // Pick default address
        AddressModel? defaultAddress = controller.addresses.firstWhereOrNull((a) => a.isDefault);

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery to: ',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Text(
                        defaultAddress != null
                            ? '${defaultAddress.name}, ${defaultAddress.address}, ${defaultAddress.city}, ${defaultAddress.state}, ${defaultAddress.postalCode}, ${defaultAddress.country}'
                            : 'No address added yet',
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => defaultAddress != null
                                ? AddressFormScreen(initialData: defaultAddress.toJson())
                                : const AddressFormScreen(),
                          ),
                        );
                        if (result == true) controller.fetchAddresses();
                      },
                      child: Text(
                        defaultAddress == null ? 'Add' : 'Change',
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.pink),
                      ),
                    ),
                  ],
                ),
                // ✅ Dynamic Cart Items with divider only between items
            
            
                const SizedBox(height: 15),
                Divider(color: Color(0xffECECEC)),
                const SizedBox(height: 15),
            
                Text('Order Summary', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: const Color(0xFF3D3D3D))),
                SizedBox(height: 10.h),
               OrderSummaryCard(
                items: [
                  {
                    'title': 'Period kit + Pain relief patch Combo',
                    'qty': 2,
                    'price': 2499.0,
                  },
                  {
                    'title': 'Pain relief patch Combo',
                    'qty': 2,
                    'price': 2499.0,
                  },
                ],
              ),SizedBox(height: 20.h),
                 Text('Payment Method', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: const Color(0xFF3D3D3D))),SizedBox(height: 20.h),
                UPIPaymentCard(),SizedBox(height: 20.h),
                Text('Order Summary', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: const Color(0xFF3D3D3D))),

                SizedBox(height: 10.h),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F8F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffE8ECF4)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 6.h),
                      _summaryRow('Total Price', '₹2200'),
                      const SizedBox(height: 10),
                      _summaryRow('Discount Price', '-₹200', color: Colors.green),
                      const SizedBox(height: 10),
                      const Divider(height: 20, color: Color(0xffDEDEDE)),
                      _summaryRow('Total Payable Amount', '₹2000', isBold: true, size: 16),
                    ],
                  ),
                ),
                SizedBox(height: 35.h),
            
                // Terms & Policy
               
                const SizedBox(height: 30),
            
                // Place Order Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC61469),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: defaultAddress == null
                        ? null
                        : () {
                            // TODO: proceed with checkout using defaultAddress
                          },
                    child: Text(
                      'Place 4999',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false, double size = 14, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: size, fontWeight: isBold ? FontWeight.w600 : FontWeight.w400, color: Colors.black)),
        Text(value, style: GoogleFonts.poppins(fontSize: size, fontWeight: isBold ? FontWeight.w600 : FontWeight.w400, color: color ?? Colors.black)),
      ],
    );
  }
}
