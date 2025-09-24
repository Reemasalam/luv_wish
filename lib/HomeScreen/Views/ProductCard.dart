import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/CartScreen/Services/CartController.dart';
import 'package:luve_wish/HomeScreen/Models/ProductModel.dart';
import 'package:luve_wish/Wishlist/Service/WishlistController.dart';


class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onAddToWish;
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;

  const ProductCard({
    super.key,
    required this.product,
    this.onAddToWish,
    this.onAddToCart,
    this.onBuyNow,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
 
  int quantity = 0; // track selected quantity
  bool isWished = false;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController()); // 👈 inject CartController
    final wishlistController = Get.put(WishlistController());
    final mainImage = widget.product.images.isNotEmpty
        ? widget.product.images.first.url
        : "assets/placeholder.png";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image + Wish Icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  mainImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/placeholder.png", height: 180),
                ),
              ),
             Positioned(
  right: 8,
  top: 8,
  child: GestureDetector(
    onTap: () async {
      final wishlistController = Get.put(WishlistController());

      // Toggle the icon state immediately
      setState(() => isWished = !isWished);

      try {
        if (isWished) {
          // Add to wishlist
          await wishlistController.addToWishlist(widget.product.id);
        } else {
          // Remove from wishlist (if you have wishlistId)
          // You would need a way to find wishlistId from productId
          // For now, just toggle the icon
          Get.snackbar("Removed", "${widget.product.name} removed from wishlist");
        }

        // Call any callback
        if (widget.onAddToWish != null) widget.onAddToWish!();
      } catch (e) {
        // If error occurs, revert icon state
        setState(() => isWished = !isWished);
        Get.snackbar("Error", e.toString());
      }
    },
    child: CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: Icon(
        isWished ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
    ),
  ),
),

            ],
          ),

          const SizedBox(height: 10),

          // Product Title
          Text(
            widget.product.name,
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

          const SizedBox(height: 8),

          // Row: Left = Price, Right = Stock + Quantity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price & Strike Price on Left
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹${widget.product.discountedPrice.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${widget.product.actualPrice.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),

              // Stock above quantity on Right
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${widget.product.stockCount}+ stock",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _qtyBtn("-", () {
                        if (quantity > 0) {
                          setState(() {
                            quantity--;
                          });
                        }
                      }),
                      _qtyDisplay(quantity.toString()),
                      _qtyBtn("+", () {
                        if (quantity < widget.product.stockCount) {
                          setState(() {
                            quantity++;
                          });
                        }
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
         Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    // Buy Now Button
    ElevatedButton.icon(
      onPressed: widget.onBuyNow,
      icon: Image.asset(
        "assets/fi.png",
        height: 16,
        color: Colors.white, // ensure icon color is white
      ),
      label: const Text(
        "Buy Now",
        style: TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff4AD082)), // enforce green
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    const SizedBox(width: 8),
    // Add to Cart Button
     ElevatedButton.icon(
                onPressed: () async {
                  if (quantity > 0) {
                    await cartController.addToCart(widget.product.id, quantity);
                    Get.snackbar("Success", "${widget.product.name} added to cart");
                    widget.onAddToCart?.call();
                  } else {
                    Get.snackbar("Quantity Required", "Please select at least 1 quantity");
                  }
                },
                icon: const Icon(Icons.shopping_cart, size: 16, color: Colors.white),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2B70D4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
  



        ],
      ),
    );
  }

  // Quantity Button
  Widget _qtyBtn(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }

  // Quantity Display
  Widget _qtyDisplay(String number) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        number,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
