import 'package:flutter/material.dart';
import 'package:luve_wish/CartScreen/PayScreen.dart';
import 'package:luve_wish/CartScreen/Views/OrderCard.dart';

class ShoppingBagScreen extends StatelessWidget {
  const ShoppingBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Shopping Bag',
          style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontWeight: FontWeight.w600,fontSize: 18),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.favorite_border, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: OrderCard(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.local_offer_outlined, color: Colors.black),
                const SizedBox(width: 8),
                const Text('Apply Coupons', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Montserrat')),
                const Spacer(),
                Text('Select', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500,fontFamily: 'Montserrat')),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(thickness: 1.0),
          ),

          // Order Payment Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Payment Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,fontFamily: 'Montserrat'),
                ),
                const SizedBox(height: 16),
                _rowTile('Order Amounts', '₹ 7,000.00'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text('Convenience',style: TextStyle( fontSize: 12,fontFamily: 'Montserrat')),
                        SizedBox(width: 4),
                        Text('Know More', style: TextStyle(color: Colors.red, fontSize: 12,fontFamily: 'Montserrat')),
                      ],
                    ),
                    Text('Apply Coupon', style: TextStyle(color: Colors.red.shade400, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 10),
                _rowTile('Delivery Fee', 'Rs 60'),
                const Text('Shipping in India - Rs 60', style: TextStyle(color: Colors.grey, fontSize: 12,fontFamily: 'Montserrat')),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(thickness: 1.0),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _rowTile('Order Total', '₹ 7,000.00', ),
          ),

          const Spacer(),

          // Bottom Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '₹ 7,000.00',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,fontFamily: 'Montserrat'),
                    ),
                    Text(
                      'View Details',
                      style: TextStyle(color: Colors.red, fontSize: 12,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF83758),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>PayScreen()));},
                  child: const Text('Proceed to Payment', style: TextStyle(fontSize: 16,fontFamily: 'Montserrat',color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowTile(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.bold,fontFamily: 'Montserrat')),
        Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.bold,fontFamily: 'Montserrat')),
      ],
    );
  }
}
