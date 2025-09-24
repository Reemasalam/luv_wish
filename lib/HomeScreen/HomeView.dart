import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:luve_wish/HomeScreen/Services/HomeController.dart';

import 'package:luve_wish/HomeScreen/Views/Featurecard.dart';
import 'package:luve_wish/HomeScreen/Views/ProductCard.dart';
import 'package:luve_wish/HomeScreen/Views/SpecialOfferCard.dart';
import 'package:luve_wish/Src/AppButton.dart';
import 'package:luve_wish/ProfileScreen/ProfileScreen.dart';

class HomeMainScreen extends StatelessWidget {
  HomeMainScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  //final List<Map<String, dynamic>> categories = const [
    //{"label": "Sanitary Pads", "icon": Icons.local_offer},
   // {"label": "Hygiene Products", "icon": Icons.health_and_safety},
   // {"label": "Body Lotions", "icon": Icons.spa},
   // {"label": "Makeup", "icon": Icons.brush},
   // {"label": "Skin Care", "icon": Icons.face},
 // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            radius: 18,
            child: const Icon(Icons.menu, color: Colors.black, size: 18),
          ),
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
              child: const CircleAvatar(
                backgroundColor: Colors.black12,
                radius: 18,
                child: Icon(Icons.person, color: Colors.black, size: 18),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar
            _buildSearchBar(),

            const SizedBox(height: 20),

            // ⭐ Featured Section
            _buildFeaturedHeader(),
            const SizedBox(height: 16),
            const FeatureCard(),

            const SizedBox(height: 20),

            // 📂 Categories
            //_buildCategories(),

            const SizedBox(height: 25),

            // 🛒 Deal of the Day
            _buildDealOfTheDay(),

            const SizedBox(height: 24),

            // 👀 Products Section
            Text("View Products",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),

            // ✅ Product Cards (Dynamic with GetX)
           
          // ✅ Product Cards (Dynamic with GetX)
Obx(() {
  if (productController.isLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }
  if (productController.error.value != null) {
    return Center(child: Text(productController.error.value!));
  }
  if (productController.products.isEmpty) {
    return const Center(child: Text("No products available"));
  }

  // Optional: maintain quantity per product
  Map<String, int> quantities = {}; // key = product.id

  return  ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: productController.products.length,
  itemBuilder: (context, index) {
    final product = productController.products[index];

    return ProductCard(
      product: product, // 👈 pass product here
      onAddToWish: () {
        // TODO: integrate wishlist API
        Get.snackbar("Wishlist", "${product.name} added to wishlist!");
      },
    );
  },
);

}),

            const SizedBox(height: 20),

            // 🔥 Trending
            _buildTrending(),

            const SizedBox(height: 24),

            // 🎁 Special Offers
            const SpecialOfferCard(),

            const SizedBox(height: 20),

            // 🛍️ Buy Now Button
            Center(
              child: AppButton(
                text: "Buy Now",
                onPressed: () {
                  // Add your onTap logic here
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- UI Sub-widgets ---
  Widget _buildSearchBar() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const TextField(
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Search any Product...',
            hintStyle: TextStyle(color: Color(0xFFBBBBBB), fontSize: 15),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            icon: Icon(Icons.search, color: Color(0xFFBBBBBB)),
            suffixIcon: Icon(Icons.mic_none_outlined, color: Color(0xFFBBBBBB)),
          ),
        ),
      );

  Widget _buildFeaturedHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("All Featured",
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.w600)),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFFAF9F9),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Sort"),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFFAF9F9),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.tune, size: 16),
                label: const Text("Filter"),
              ),
            ],
          )
        ],
      );

  //Widget _buildCategories() => Column(
    //    crossAxisAlignment: CrossAxisAlignment.start,
      //  children: [
        //  Text("Select Category",
          //    style: GoogleFonts.poppins(
            //      fontSize: 18, fontWeight: FontWeight.w600)),
         // const SizedBox(height: 12),
          //SizedBox(
            //height: 100,
           // child: ListView.separated(
             // scrollDirection: Axis.horizontal,
            //  itemCount: categories.length,
            //  separatorBuilder: (context, index) => const SizedBox(width: 16),
             /// itemBuilder: (context, index) {
               // final category = categories[index];
               // return Column(
                 // children: [
                   // GestureDetector(
                     /// onTap: () {
                        // TODO: Filter products by category
                     // },
                     /// child: Container(
                      //  width: 60,
                        //height: 60,
                       // decoration: BoxDecoration(
                         /// color: Colors.pink.shade100,
                         // shape: BoxShape.circle,
                       // ),
                        //child: Icon(category["icon"],
                         //   color: Colors.pink, size: 30),
                     // ),
                    //),
                    //const SizedBox(height: 5),
                    //SizedBox(
                     // width: 70,
                      //child: Text(category["label"],
                        //  style: GoogleFonts.poppins(
                          //    fontSize: 12, fontWeight: FontWeight.w500),
                          //textAlign: TextAlign.center,
                         // maxLines: 2,
                         // overflow: TextOverflow.ellipsis),
                   // )
                  //],
                //);
              //},
            //),
         // ),
        //],
      //);

  Widget _buildDealOfTheDay() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff4392F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Deal of the Day",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white)),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.access_time, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                Text("22h 55m 20s remaining",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.white)),
              ]),
            ]),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(children: [
                Text("View all",
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward,
                    size: 14, color: Colors.white),
              ]),
            ),
          ],
        ),
      );

  Widget _buildTrending() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffEB147D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Trending Products",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white)),
              const SizedBox(height: 10),
              Row(children: [
                const Icon(Icons.calendar_today,
                    size: 14, color: Colors.white),
                const SizedBox(width: 8),
                Text("Late Date 29/02/22",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.white)),
              ]),
            ]),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(children: [
                Text("View all",
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward,
                    size: 14, color: Colors.white),
              ]),
            ),
          ],
        ),
      );
}
