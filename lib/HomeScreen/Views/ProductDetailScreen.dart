import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/HomeScreen/Models/ProductModel.dart';
import 'package:luve_wish/HomeScreen/Views/Components/ProductCard.dart';
import 'package:luve_wish/HomeScreen/Views/Components/ProductsCard.dart';
import 'package:luve_wish/CartScreen/Services/CartController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product; // ✅ directly receive product
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final cartController = Get.put(CartController());
  final PageController pageController = PageController();
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final imageList = product.images.map((img) => img.url).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
      onPressed: () => Get.back(),
    ),
    title: Image.asset(
      'assets/logo.png',
      height: 23,
      fit: BoxFit.contain,
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.share, color: Colors.black87),
        onPressed: () {
          // TODO: Add export/share functionality here
        },
      ),
    ],
  ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
        
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image carousel
                  SizedBox(
                    height: 370,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          controller: pageController,
                          itemCount: imageList.isNotEmpty ? imageList.length : 1,
                          itemBuilder: (context, index) {
                            final image = imageList.isNotEmpty ? imageList[index] : '';
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: image.isNotEmpty
                                      ? Image.network(image, fit: BoxFit.cover)
                                      : const Icon(Icons.image, size: 60, color: Colors.grey),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 15,
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: imageList.isNotEmpty ? imageList.length : 1,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Color(0xFFFF7BA9),
                              dotColor: Colors.grey,
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ),
        
                  // Product details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          product.categoryName,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff999999),
                          ),
                        ),
                        Text(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                       
                     
        
                        // Pricing section
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "₹${product.discountedPrice.toStringAsFixed(0)}",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color:  Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (product.actualPrice > product.discountedPrice)
                              Text(
                                "₹${product.actualPrice.toStringAsFixed(0)}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            const SizedBox(width: 6),
                            if (product.actualPrice > product.discountedPrice)
                              Text(
                                "${(((product.actualPrice - product.discountedPrice) / product.actualPrice) * 100).round()}% OFF",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                        // Star rating and review count
        Row(
          children: [
            // Stars
            ...List.generate(5, (index) {
        if (index < product.rating.floor()) {
          // Full star
          return const Icon(Icons.star, color: Color(0xFFFFC107), size: 18);
        } else if (index < product.rating) {
          // Half star
          return const Icon(Icons.star_half, color: Color(0xFFFFC107), size: 18);
        } else {
          // Empty star
          return const Icon(Icons.star_border, color: Color(0xFFFFC107), size: 18);
        }
            }),
            const SizedBox(width: 8),
            // Review count
            Text(
        "(${product.reviewCount})",
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey[600],
        ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        
                       
        
                        // Description
                        Text(
                          "Description",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product.description ?? "No description available.",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
        
                        Text(
  "Related Products",
  style: GoogleFonts.poppins(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
),
const SizedBox(height: 10),

// ✅ Call the ProductsCard widget here
ProductsCard(
  product: product, // or any related product instance
  width: 180,
  showCategory: true,
  isHorizontal: false,
),

                      //  here need to call productcard
                      
                      ],
                    ),
                  ),
                ],
              ),
            ),
           
            // Bottom buttons
          Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 10,
          ),
        ],
            ),
            child: Row(
        children: [
          // Love Icon (plain)
          const Icon(Icons.favorite_border, color: Color(0xFFFF7BA9), size: 30),
          const SizedBox(width: 10),
        
          // Add to Bag button with icon
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                await cartController.addToCart(product.id, quantity);
                if (cartController.error.value == null) {
                  Get.snackbar(
                    "Success",
                    "Item added to your bag",
                    backgroundColor: Colors.green.shade50,
                    colorText: Colors.black,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    cartController.error.value!,
                    backgroundColor: Colors.red.shade50,
                    colorText: Colors.black,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
              label: Text(
                "Add to Bag",
                style: GoogleFonts.poppins(
                  color:Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xffCBCBCB), width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 15),
        
          // Buy Now button with icon
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Get.toNamed("/checkout", arguments: {
                  "productId": product.id,
                  "quantity": quantity,
                });
              },
              icon: const Icon(Icons.flash_on, color: Colors.white),
              label: Text(
                "Buy Now",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC61469),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: const Color(0xffCBCBCB), width: 1),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
            ),
          ),
        ),
        
        
          ],
        ),
      ),
    );
  }
}
