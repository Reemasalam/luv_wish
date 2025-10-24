import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/HomeScreen/HomeView.dart';
import 'package:luve_wish/ProfileScreen/ProfileScreen.dart';
import 'package:luve_wish/Wishlist/WishlistScreen.dart';
import 'package:luve_wish/CartScreen/CheckoutScreen.dart';
import 'package:luve_wish/MyOrder/MyOrderScreen.dart';

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
    CheckoutScreen(),
    MyOrderScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(child: _pages[_selectedIndex]),
    bottomNavigationBar: SafeArea(
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navIcon(icon: Icons.home_outlined, selectedIcon: Icons.home, index: 0),
            _navIcon(icon: Icons.favorite_border, selectedIcon: Icons.favorite, index: 1),
            _navIcon(icon: Icons.local_shipping, selectedIcon: Icons.local_shipping, index: 2),
            _navIcon(icon: Icons.card_giftcard, selectedIcon: Icons.card_giftcard, index: 3),
            _navIcon(icon: Icons.person_outline, selectedIcon: Icons.person, index: 4),
          ],
        ),
      ),
    ),
  );
}


  Widget _navIcon({
    required IconData icon,
    required IconData selectedIcon,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Icon(
        isSelected ? selectedIcon : icon,
        size: 30,
        color: isSelected ? const Color(0xffC61469) : Colors.grey,
      ),
    );
  }
}
