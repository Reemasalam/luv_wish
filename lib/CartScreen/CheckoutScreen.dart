import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/CartScreen/AddressFormScreen.dart';
import 'package:luve_wish/CartScreen/OrderConfirmation.dart';
import 'package:luve_wish/CartScreen/Services/CartController.dart';
import 'package:luve_wish/CartScreen/Services/CheckoutController.dart';
import 'package:luve_wish/CartScreen/Views/CartProductCard.dart';
import 'package:luve_wish/CartScreen/Views/CoupenCard.dart';
import 'package:luve_wish/CartScreen/Model/AddressModel.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  // Use Get.find so the same instances are reused (avoid duplicate Get.put)
  final CheckoutController controller = Get.put(CheckoutController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await cartController.fetchCart();      // 1) cart first
      await cartController.fetchCoupons();   // 2) coupons from same controller UI reads
      controller.fetchAddresses();           // 3) addresses
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Image.asset('assets/logo.png', height: 23, fit: BoxFit.contain),
      ),
      body: Obx(() {
        AddressModel? defaultAddress =
            controller.addresses.firstWhereOrNull((a) => a.isDefault);

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ADDRESS
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery to: ',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  Expanded(
                    child: Text(
                      defaultAddress != null
                          ? '${defaultAddress.name}, ${defaultAddress.address}, ${defaultAddress.city}, ${defaultAddress.state}, ${defaultAddress.postalCode}, ${defaultAddress.country}'
                          : 'No address added yet',
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => defaultAddress != null
                              ? AddressFormScreen(
                                  initialData: defaultAddress.toJson())
                              : const AddressFormScreen(),
                        ),
                      );
                      if (result == true) controller.fetchAddresses();
                    },
                    child: Text(
                      defaultAddress == null ? 'Add' : 'Change',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // CART ITEMS
              Obx(() {
                if (cartController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (cartController.cart.value == null ||
                    cartController.cart.value!.data.isEmpty) {
                  return const Center(child: Text("Your cart is empty"));
                }

                final items = cartController.cart.value!.data;
                final children = <Widget>[];
                for (var i = 0; i < items.length; i++) {
                  children.add(CartProductCard(cartItem: items[i]));
                  if (i != items.length - 1) {
                    children.add(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Colors.grey.shade300, thickness: 1),
                      ),
                    );
                  }
                }
                return Column(children: children);
              }),

              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 15),

              // COUPON
              Obx(() {
                if (cartController.couponLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2));
                }
                if (cartController.validCoupons.isEmpty) {
                  return const Center(
                    child: Text(
                      "No valid coupons available for your cart total",
                    ),
                  );
                }
                return CouponCard(
                  coupons: cartController.validCoupons,
                  onApply: (coupon) {
                    cartController.applyCoupon(coupon);
                    if (cartController.hasDiscount.value) {
                      Get.snackbar(
                        "Coupon Applied",
                        "${coupon.couponName} applied successfully!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.shade50,
                        colorText: Colors.black,
                      );
                    } else {
                      Get.snackbar(
                        "Coupon Not Applied",
                        "Coupon is not eligible for the current cart.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade50,
                        colorText: Colors.black,
                      );
                    }
                  },
                );
              }),

              const SizedBox(height: 16),

              // ORDER SUMMARY
              Obx(() {
                final total = cartController.getTotalPrice();
                final discount = cartController.discountAmount.value;
                final payable = (total - discount).clamp(0, double.infinity);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Summary',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w600)),
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
                          _summaryRow(
                              'Total Price', '₹${total.toStringAsFixed(2)}'),
                          const SizedBox(height: 10),
                          if (cartController.hasDiscount.value && discount > 0)
                            _summaryRow('Discount',
                                '-₹${discount.toStringAsFixed(2)}',
                                color: Colors.green),
                          const SizedBox(height: 10),
                          const Divider(height: 20, color: Color(0xffDEDEDE)),
                          _summaryRow('Total Payable Amount',
                              '₹${payable.toStringAsFixed(2)}',
                              isBold: true, size: 16),
                        ],
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 35.h),

              // TERMS
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'By placing the order, you agree to Luvwish\n',
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xff4A5565)),
                    children: [
                      TextSpan(
                        text: 'Terms of Use and Privacy Policy',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.pink,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // PLACE ORDER
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC61469),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: defaultAddress == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderConfirmationScreen()),
                          );
                        },
                  child: Text(
                    'Place Order',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isBold = false, double size = 14, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: size,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                color: Colors.black)),
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: size,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                color: color ?? Colors.black)),
      ],
    );
  }
}
