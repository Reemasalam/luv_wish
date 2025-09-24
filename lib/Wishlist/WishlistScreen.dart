import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/ProfileScreen/ProfileScreen.dart';
import 'package:luve_wish/Wishlist/Service/WishlistController.dart';
import 'package:luve_wish/Wishlist/Views/WishlistProductCard.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());
    final searchController = TextEditingController();

    // Fetch wishlist when screen opens
    wishlistController.fetchWishlist();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "LUVWISH",
          style: GoogleFonts.libreCaslonText(
            fontSize: 18,
            color: const Color(0xffEB147D),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: const Icon(Icons.person, color: Colors.black, size: 24),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: searchController,
                onChanged: wishlistController.setSearchQuery,
                style: const TextStyle(
                  color: Color(0xFFBBBBBB),
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Search any Product...',
                  hintStyle: const TextStyle(
                    color: Color(0xFFBBBBBB),
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF9F9F9),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFBBBBBB)),
                  suffixIcon:
                      const Icon(Icons.mic_none_outlined, color: Color(0xFFBBBBBB)),
                ),
              ),
            ),

            // Sort & Filter buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _showSortDialog(context, wishlistController);
                  },
                  icon: const Icon(Icons.sort, size: 16),
                  label: const Text("Sort"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    _showFilterDialog(context, wishlistController);
                  },
                  icon: const Icon(Icons.tune, size: 16),
                  label: const Text("Filter"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Wishlist Products List
            Expanded(
              child: Obx(() {
                if (wishlistController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                var filteredWishlist = wishlistController.filteredWishlist;

                if (filteredWishlist.isEmpty) {
                  return const Center(
                      child: Text("No items in wishlist",
                          style: TextStyle(fontSize: 16)));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredWishlist.length,
                  itemBuilder: (context, index) {
                    final wishlistItem = filteredWishlist[index];
                    return Column(
                      children: [
                        WishlistProductCard(
                          wishlistItem: wishlistItem,
                          onBuyNow: () {
                            print(
                                "Buy now pressed for ${wishlistItem.product?.name}");
                          },
                          onDelete: () {
                            wishlistController
                                .removeFromWishlist(wishlistItem.wishlistId);
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // SORT Dialog
  void _showSortDialog(
      BuildContext context, WishlistController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.arrow_upward),
              title: const Text("Price: Low to High"),
              onTap: () {
                controller.setSortOption("asc");
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_downward),
              title: const Text("Price: High to Low"),
              onTap: () {
                controller.setSortOption("desc");
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text("Reset"),
              onTap: () {
                controller.setSortOption('');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  // FILTER Dialog
  void _showFilterDialog(
      BuildContext context, WishlistController controller) {
    final minPriceController =
        TextEditingController(text: controller.minPrice.value.toString());
    final maxPriceController = TextEditingController(
        text: controller.maxPrice.value == double.infinity
            ? ''
            : controller.maxPrice.value.toString());

    Get.dialog(
      AlertDialog(
        title: const Text("Filter by Price"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: minPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Min Price"),
            ),
            TextField(
              controller: maxPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Max Price"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.setMinPrice(0.0);
              controller.setMaxPrice(double.infinity);
              Get.back();
            },
            child: const Text("Reset"),
          ),
          ElevatedButton(
            onPressed: () {
              final min =
                  double.tryParse(minPriceController.text) ?? 0.0;
              final max = double.tryParse(maxPriceController.text) ??
                  double.infinity;
              controller.setMinPrice(min);
              controller.setMaxPrice(max);
              Get.back();
            },
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }
}
