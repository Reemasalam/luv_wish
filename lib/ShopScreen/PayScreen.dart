import 'package:flutter/material.dart';
import 'package:luve_wish/Src/AppButton.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  int selectedPayment = 0;

  List<Map<String, String>> paymentOptions = [
    {
      'title': 'Card',
      'image': 'assets/visa.png', 
      'value': '********2109'
    },
    {
      'title': 'GPay',
      'image': 'assets/gpay.png',
      'value': '********321'
    },
    {
      'title': 'Net Banking',
      'image': 'assets/netbanking.png',
      'value': '********2109'
    },
  ];

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            const Text(
              "Payment done successfully.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(int index) {
    final option = paymentOptions[index];
    bool isSelected = selectedPayment == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: Colors.redAccent)
              : Border.all(color: Color(0xffF4F4F4)),
          color: isSelected ? Colors.red.shade50 : Colors.grey.shade100,
        ),
        child: Row(
          children: [
            Image.asset(
              option['image']!,
              height: 28,
              width: 28,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                option['title']!,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text(
              option['value']!,
              style: const TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:IconButton(  icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),),
        title: const Text('Checkout', style: TextStyle(color: Colors.black,fontSize:18,fontWeight:FontWeight.w700,fontFamily: 'Montserrat' )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Order", style: TextStyle(color: Color(0xffA8A8A9),fontSize:18,fontWeight:FontWeight.w500,fontFamily: 'Montserrat' )),
                Text("₹ 7,000", style: TextStyle(color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Shipping",  style: TextStyle(color: Color(0xffA8A8A9),fontSize:18,fontWeight:FontWeight.w500,fontFamily: 'Montserrat' )),
                Text("₹ 30", style: TextStyle(color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 12),
            // Total before divider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Total", style: TextStyle(fontSize: 18,fontFamily: 'Montserrat', fontWeight: FontWeight.w400)),
                Text("₹ 7,030", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),

            const SizedBox(height: 20),
            const Text("Payment", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            // Payment Options
            ...List.generate(paymentOptions.length, _buildPaymentOption),

            const Spacer(),

         Center(
  child: AppButton(
    text: "Check Out",
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> PayScreen()));
    }, backgroundColor: Color(0xffF83758),
  ),
),

          ],
        ),
      ),
    );
  }
}
