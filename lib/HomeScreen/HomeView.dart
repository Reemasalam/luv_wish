import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/HomeScreen/Models/ProductModel.dart';

import 'package:luve_wish/HomeScreen/Services/HomeController.dart';
import 'package:luve_wish/HomeScreen/Views/Components/HomeBanner.dart';
import 'package:luve_wish/HomeScreen/Views/Components/Homeappbar.dart';
import 'package:luve_wish/HomeScreen/Views/Components/Homecategory.dart';
import 'package:luve_wish/HomeScreen/Views/Components/Homesearchbar.dart';
import 'package:luve_wish/HomeScreen/Views/Components/ProductCard.dart';
import 'package:luve_wish/HomeScreen/Views/Components/ReviewCard.dart';
import 'package:luve_wish/HomeScreen/Views/Components/SocialStripe.dart';
import 'package:luve_wish/HomeScreen/Views/Components/ProductsCard.dart';
import 'package:luve_wish/HomeScreen/Views/ProductDetailScreen.dart';
import 'package:luve_wish/Wishlist/Service/WishlistController.dart';

class HomeMainScreen extends StatelessWidget {
  HomeMainScreen({super.key});

  final ProductController productController = Get.put(ProductController());
   final WishlistController wishlistController = Get.put(WishlistController());
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            HomeSearchBar(onChanged: productController.setSearch),
            const SizedBox(height: 20),

            const HomeBanner(),
            const SizedBox(height: 16),

            const HomeCategoryStrip(),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Discover Products",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF000000),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🧱 Inline Product Grid (uses ProductsCard)
            Obx(() {
              if (productController.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (productController.error.value != null) {
                return Center(child: Text(productController.error.value!));
              }

              final products = productController.filteredProducts;
              if (products.isEmpty) {
                return const Center(child: Text("No products available"));
              }

              return GridView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                 mainAxisExtent: 340, // you can tweak height if needed
                  crossAxisSpacing: 20,
                  mainAxisSpacing:20,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductsCard(
                    product: product,
                    showCategory: true,
                    isHorizontal: false,
                  );
                },
              );
            }),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "All in One Periods Solution",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000000),
                ),
              ),
            ),

            const SizedBox(height: 8),
               Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 110.h,
                child: Obx(() {
                  final products = productController.products;
                  if (products.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final imageUrl = _mainImageUrl(product) ?? '';
                      final discountPercent = product.actualPrice > 0
                          ? ((product.actualPrice - product.discountedPrice) /
                                  product.actualPrice *
                                  100)
                              .round()
                          : 0;

                      return SizedBox(
                        width: 332.w,
                        child: ProductCardSym(
                          imageUrl: imageUrl,
                          title: product.name,
                          price: product.discountedPrice,
                          mrp: product.actualPrice,
                          discountPercent: discountPercent,
                          onTap: () => Get.to(
                            () => ProductDetailScreen(product: product),
                          ),
                          onMoveToBag: () {},
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
           
            const SizedBox(height: 20),

            const HomeReviewCard(),
            const SizedBox(height: 16),

            Text(
              "Some Real Story from Social Media",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),

            const SizedBox(height: 16),
            const HomeSocialStrip(),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
