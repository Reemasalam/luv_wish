import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/HomeScreen/Views/ProductCard.dart';
import 'package:luve_wish/CartScreen/CheckoutScreen.dart';
import 'package:luve_wish/ShoppingBagScreen/ShoppingBagScreen.dart';
import 'package:luve_wish/Src/AppButton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final PageController _pageController = PageController();
  int quantity = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart_outlined, color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Carousel
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image.asset("assets/periodkit.png", fit: BoxFit.cover);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const WormEffect(dotColor: Colors.grey, activeDotColor: Colors.pink),
              ),
            ),

            const SizedBox(height: 20),

            // Title
            Text(
              "Period kit + Pain relief patch Combo",
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              "Period Essential",
              style: GoogleFonts.poppins(color: Colors.black,fontSize: 14),
            ),

            const SizedBox(height: 12),
            // Price, Discount, Rating, Quantity in One Row with alignment
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    // Left: Price + Rating
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("₹2,999",
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14)),
            const SizedBox(width: 8),
            Text("₹1,500",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text("50% Off",
                style: GoogleFonts.poppins(
                    color: Colors.pink, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: const [
            Icon(Icons.star, color: Colors.amber, size: 20),
            SizedBox(width: 4),
            Text("4.7", style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(width: 4),
            Text("56,890", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    ),
 const SizedBox(width: 8),
    // Right: Quantity + Stock
    Row(
      children: [
        _qtyBtn("-", () {
          if (quantity > 1) {
            setState(() => quantity--);
          }
        }),
        _qtyDisplay(quantity.toString()),
        _qtyBtn("+", () {
          setState(() => quantity++);
        }),
        const SizedBox(width: 8),
        Text("5+ stock",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black)),
      ],
    ),
  ],
),

            // Price & Discount
           
            const SizedBox(height: 16),

            // Description
            Text("Product Details", style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              "Each kit includes five sanitary pads, a 25ml sanitizer, and five toilet sheets for hygiene on the go.\n\n"
              "Disposable bags and tissues ensure easy waste management and added convenience.\n\n"
              "A sweet treat of dark chocolate is included to uplift your mood during your cycle.\n\n"
              "We also offer a hygiene pack variant with a pad, sanitizer, disposable bag, tissue, and chocolate.\n\n"
              "Available in two sizes and flavors, our packs support daily hygiene and boost confidence.",
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
            ),

            const SizedBox(height: 20),
Row(
  children: [
    // Buy Now Button
    Expanded(
      child: SizedBox(
        height: 36,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=> CheckoutScreen()));
          },
          icon: const Icon(Icons.touch_app, color: Colors.white, size: 18),
          label: Text(
            "Buy Now",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4AD082),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    ),
    const SizedBox(width: 12),

    // Go to Cart Button
    Expanded(
      child: SizedBox(
        height: 36,width: 80,
        child: ElevatedButton.icon(
          onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=> ShoppingBagScreen()));
          },
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 18),
          label: Text(
            "Go to cart",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2B70D4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    ),
  ],
),


            const SizedBox(height: 32),

            // Related Products
            Text("Related Products", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),
           // const ProductCard(),
            //const ProductCard(),
          ],
        ),
      ),
    );
  }

  Widget _qtyBtn(String symbol, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
       // margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        
        ),
        child: Text(symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _qtyDisplay(String count) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
       
      ),
      child: Text(count),
    );
  }
}
