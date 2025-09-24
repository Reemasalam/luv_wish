import 'package:flutter/material.dart';
import 'package:luve_wish/MyOrder/TrackOrderScreen.dart';
import 'package:luve_wish/MyOrder/Views/HistoryCard.dart';
import 'package:luve_wish/CartScreen/Views/OrderCard.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatr.png'), // user profile image
              radius: 16,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Live orders", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            // Live Order Card
        GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TrackOrderScreen()),
    );
  },
  child: OrderCard(), // or HistoryCard(), etc.
),

            const SizedBox(height: 20),
            const Text("History", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
        HistoryCard()
        
          ],
        ),
      ),
    );
  }

}