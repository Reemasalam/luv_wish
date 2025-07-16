import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/HomeScreen/Views/Featurecard.dart';
import 'package:luve_wish/HomeScreen/Views/ProductCard.dart';
import 'package:luve_wish/HomeScreen/Views/SpecialOfferCard.dart';
import 'package:luve_wish/Src/AppButton.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.black12,
              radius: 18,
              child: Icon(Icons.person, color: Colors.black, size: 18),
            ),
          )
        ],
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
  style: const TextStyle(
    color: Color(0xFFBBBBBB), 
    fontSize: 14,
  ),
  decoration: const InputDecoration(
    hintText: 'Search any Product...',
    hintStyle: TextStyle(
      color: Color(0xFFBBBBBB), 
      fontSize: 15,
    ),
    border: InputBorder.none,
    isDense: true, 
    contentPadding: EdgeInsets.symmetric(vertical: 12), 
    icon: Icon(Icons.search, color: Color(0xFFBBBBBB)),
    suffixIcon: Icon(Icons.mic_none_outlined, color: Color(0xFFBBBBBB)),
  ),
),

            ),
            const SizedBox(height: 20),

            // All Featured + Sort Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Featured",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFFAF9F9),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
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
            ),
            const SizedBox(height: 16),

            

            const SizedBox(height: 24),

            // View Products Header
            Text("View Products",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),

            // Product Card(s)
            const ProductCard(),
            const ProductCard(), 
              Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Color(0xffEB147D),
    borderRadius: BorderRadius.circular(10),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Left: Deal + Time with Clock
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Treanding Products",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 16,color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                "Late Date 29/02/22",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      ),

      // Right: View All Button
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white,width: 2)
        ),
        child: Row(
          children: [
           
            Text(
              "View all",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ), const SizedBox(width: 4), const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
           
          ],
        ),
      ),
    ],
  ),
),
SpecialOfferCard(),
SizedBox(height: 20,),
   Center(
     child: AppButton(
      text: "Buy Now",
      onPressed: () {
        // Add your onTap logic here
      },
       ),
   ),SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
