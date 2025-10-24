import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'package:luve_wish/CartScreen/Model/CartModel.dart';
import 'package:luve_wish/CartScreen/Services/CartController.dart';

class CartProductCard extends StatelessWidget {
  final CartItem cartItem;
  final bool showDivider; // 👈 To control divider visibility between cards

  const CartProductCard({
    super.key,
    required this.cartItem,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Obx(() {
      // Always fetch the latest cart item
      final updatedItem = controller.cart.value?.data
          .firstWhereOrNull((item) => item.productId == cartItem.productId);

      if (updatedItem == null || updatedItem.product == null) {
        return const SizedBox.shrink();
      }

      final product = updatedItem.product!;
      final qty = updatedItem.quantity ?? 0;

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.images.isNotEmpty
                      ? Image.network(
                          product.images.first.url,
                          height: 107.h,
                          width: 92.w,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 107.h,
                          width: 92.w,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                ),
                SizedBox(width: 12.w),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        product.name,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Quantity and Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _quantitySelector(controller, updatedItem),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${product.discountedPrice.toStringAsFixed(0)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              if (product.actualPrice > product.discountedPrice)
                                Text(
                                  '₹${product.actualPrice.toStringAsFixed(0)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
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
          ),

          // 👇 Divider shown only between cards (not first/last)
          if (showDivider)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(
                height: 1,
                thickness: 0.7,
                color: Colors.grey.shade300,
              ),
            ),
        ],
      );
    });
  }

  Widget _quantitySelector(CartController controller, CartItem item) {
    final product = item.product!;
    final qty = item.quantity ?? 0;

    return Container(
      width: 110.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: const Color(0xffF7F8F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE8ECF4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Decrement Button
          InkWell(
            onTap: qty > 1
                ? () => controller.addToIncrement(item.productId!, -1)
                : () => controller.removeFromCart(item.id, 1),
            child: const Icon(Icons.remove, size: 18),
          ),

          // Quantity Display (Reactive)
          Text(
            '$qty',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          // Increment Button
          InkWell(
            onTap: qty < (product.stockCount)
                ? () => controller.addToIncrement(item.productId!, 1)
                : null,
            child: const Icon(Icons.add, size: 18),
          ),
        ],
      ),
    );
  }
}
