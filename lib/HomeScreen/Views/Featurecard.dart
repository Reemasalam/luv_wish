import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,width: 390,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: ClipRRect(
          
              child: Image.asset(
                'assets/featureback.png', 
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay Content
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.pink.withOpacity(0.15), // slight overlay
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text(
                    "50-40% OFF",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Kits that care.\nSubscriptions that save",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Shop Now →",style: TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontSize: 14),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
