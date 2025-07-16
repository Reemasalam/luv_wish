import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pink.shade100),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/periodkit.png',
              height: 90,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Period Pain Relief',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
               

                // Quantity row
                Row(
                  children: [
                    const Text('Quantity :  '),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('3', style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),

              

                // Star rating
                Row(
                  children: const [
                    Text('4.8', style: TextStyle(fontSize: 13)),
                    SizedBox(width: 4),
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Icon(Icons.star_border, size: 16, color: Colors.amber),
                  ],
                ),

                

                // Price and Buy Now row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price column
                    Row(
                     // crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Rs.340.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(width:10),
                        Column(
                          children: [
                            Text(
                              'upto 33% off',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                        
                        SizedBox(height: 2),
                        Text(
                          'Rs540.00',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),  ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Buy Now button
                    ElevatedButton.icon(
                      onPressed: () {},
                     icon: const Icon(Icons.touch_app, color: Colors.white, size: 18),
                      label: const Text("Buy Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
