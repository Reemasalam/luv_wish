import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luve_wish/ProfileScreen/ProfileScreen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70); 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Image on left
          Image.asset(
            'assets/logo.png', // replace with your logo path
            height: 23,
            width: 90.w,
          ),
          // Claim Your Offer button + gift icon
         
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xffFFEEC8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      'Claim Your Offer',
                      style: GoogleFonts.libreCaslonText(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),const SizedBox(width: 8),
                      Icon(
                Icons.card_giftcard, // gift box icon
                color: const Color.fromARGB(255, 222, 43, 49),
                size: 28,
              ),
                  ],
                ),
              ),
              
            
          
        ],
      ),
    );
  }
}
