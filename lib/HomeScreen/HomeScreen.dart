import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luve_wish/HomeScreen/HomeView.dart';
import 'package:luve_wish/MyOrder/MyOrderScreen.dart';
import 'package:luve_wish/CartScreen/Shopscreen.dart';
import 'package:luve_wish/Wishlist/WishlistScreen.dart';

void main() {
  runApp(const MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeMainScreen(),
     WishlistScreen(),
     ShopScreen(),
     MyOrdersScreen(),
    Center(child: Text("Settings")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(icon: Icons.home_outlined, label: 'Home', index: 0),
                  _navItem(icon: Icons.favorite_border, label: 'Wishlist', index: 1),
                  const SizedBox(width: 60), // space for the cart icon
                  _navItem(icon: Icons.search, label: 'Search', index: 3),
                  _navItem(icon: Icons.settings, label: 'Setting', index: 4),
                ],
              ),
            ),
          ),

          // Floating Cart Button in Center
          Positioned(
            top: -10,
            child: GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 6),
                  ],
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: _selectedIndex == 2 ? Colors.pink : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.pink : Colors.black,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isSelected ? Colors.pink : Colors.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
