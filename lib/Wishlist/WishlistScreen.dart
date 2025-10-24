import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/HomeScreen/Views/ProductDetailScreen.dart';
import 'package:luve_wish/CartScreen/Services/CartController.dart';
import 'package:luve_wish/Wishlist/Service/WishlistController.dart';
import 'package:luve_wish/Wishlist/Views/WishlistProductCard.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());
    final cartController = Get.put(CartController());

    // Fetch wishlist when screen opens
    wishlistController.fetchWishlist();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Image.asset(
          'assets/logo.png',
          height: 23,
          fit: BoxFit.contain,
        ),
      ),
      body: Obx(() {
        if (wishlistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        var filteredWishlist = wishlistController.filteredWishlist;

        if (filteredWishlist.isEmpty) {
          return const Center(
            child: Text("No items in wishlist", style: TextStyle(fontSize: 16)),
          );
        }

        // Check if there are any out-of-stock items
        bool hasOutOfStock = filteredWishlist.any((item) =>
            item.product == null || item.product!.stockCount == 0);

        return Column(
          children: [
            // Wishlist List
           Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    itemCount: filteredWishlist.length + 1, // +1 for "Move All to Bag" button
    itemBuilder: (context, index) {
      if (index < filteredWishlist.length) {
        final wishlistItem = filteredWishlist[index];
        final product = wishlistItem.product;
        if (product == null) return const SizedBox();

        return Column(
          children: [
            WishlistProductCard(
              wishlistProduct: wishlistItem,
              onTap: () => Get.to(() => ProductDetailScreen(product: product)),
              onMoveToBag: () async {
                if (product.stockCount > 0) {
                  await cartController.addToCart(product.id, 1);
                  wishlistController.removeFromWishlist(wishlistItem.wishlistId);
                } else {
                  Get.snackbar(
                    "Out of Stock",
                    "${product.name} is out of stock",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      } else {
        // Move All to Bag button
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton(
              onPressed: () async {
                bool anyOutOfStock = false;
                for (var item in filteredWishlist) {
                  final product = item.product;
                  if (product != null && product.stockCount > 0) {
                    await cartController.addToCart(product.id, 1);
                    wishlistController.removeFromWishlist(item.wishlistId);
                  } else {
                    anyOutOfStock = true;
                  }
                }

                if (anyOutOfStock) {
                  Get.snackbar(
                    "Notice",
                    "Some items were out of stock",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFBFBFBF), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Move All to Bag",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      }
    },
  ),
),

          

            // Move All to Bag Button
         
          ],
        );
      }),
    );
  }
}
