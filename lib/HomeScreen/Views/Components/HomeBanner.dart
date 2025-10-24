import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 277.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            SizedBox(
              width: 225.w,
              child: _HeroCard.primary(),
            ),
            SizedBox(width: 8.w),
            SizedBox(
              width: 225.w,
              child: _HeroCard.secondary(),
            ),
            // You can add more cards here if needed
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.asset});

  final String asset;

  // Factories do not need to be const
  factory _HeroCard.primary() => _HeroCard(
        asset: 'assets/sanitizer.png', // replace with your image
      );

  factory _HeroCard.secondary() => _HeroCard(
        asset: 'assets/sanitizer.png', // replace with your image
      );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        asset,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
