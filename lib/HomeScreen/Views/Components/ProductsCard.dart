import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/HomeScreen/Models/ProductModel.dart';
import 'package:luve_wish/HomeScreen/Views/ProductDetailScreen.dart';
import 'package:luve_wish/Wishlist/Service/WishlistController.dart';

class ProductsCard extends StatelessWidget {
  final Product product;
  final double width;
  final bool showCategory;
  final bool isHorizontal;

  const ProductsCard({
    super.key,
    required this.product,
    this.width = 180,
    this.showCategory = true,
    this.isHorizontal = false,
  });

  String? _mainImageUrl(Product p) {
    if (p.images.isEmpty) return null;
    final main = p.images.firstWhere(
      (img) => img.isMain,
      orElse: () => p.images.first,
    );
    return main.url.isNotEmpty ? main.url : null;
  }

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());
    final imageUrl = _mainImageUrl(product);
    final double price = product.discountedPrice;
    final double mrp = product.actualPrice;
    final int offPct = (mrp > 0 && mrp > price)
        ? (((mrp - price) / mrp) * 100).round()
        : 0;

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: isHorizontal ? width : null,
        margin: isHorizontal ? const EdgeInsets.only(right: 15) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Product Image + Wishlist D
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 0.78,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7ECFF),
                        image: imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: imageUrl == null
                          ? const Center(
                              child: Icon(Icons.image,
                                  size: 48, color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                ),
                // ❤️ Wishlist Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: Obx(() {
                    final isWishlisted =
                        wishlistController.isProductWishlisted(product.id);
                    return GestureDetector(
                      onTap: () async {
                        if (isWishlisted) {
                          final item = wishlistController.wishlistItems
                              .firstWhereOrNull(
                                  (w) => w.product?.id == product.id);
                          if (item != null) {
                            await wishlistController
                                .removeFromWishlist(item.wishlistId);
                          }
                        } else {
                          await wishlistController.addToWishlist(product.id);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isWishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isWishlisted
                              ? Colors.pinkAccent
                              : Colors.grey[700],
                          size: 22,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 🏷️ Category (optional)
            if (showCategory)
              Text(
                product.categoryName,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: const Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w500,
                ),
              ),

            const SizedBox(height: 6),

            // 📦 Product Name
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                height: 1.00,
              ),
            ),

            const SizedBox(height: 6),

            // 💰 Price Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹${price.toStringAsFixed(0)}",
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                if (mrp > price)
                  Text(
                    "₹${mrp.toStringAsFixed(0)}",
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: const Color(0xFF9E9E9E),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const SizedBox(width: 6),
                if (offPct > 0)
                  Text(
                    "$offPct% off",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFF21A144),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
