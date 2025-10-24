import 'package:flutter/material.dart';

class HomeSocialStrip extends StatefulWidget {
  const HomeSocialStrip({super.key});

  @override
  State<HomeSocialStrip> createState() => _HomeSocialStripState();
}

class _HomeSocialStripState extends State<HomeSocialStrip> {
  int _currentIndex = 0;

  final List<String> _socialAssets = [
    'assets/social1.png',
    'assets/social2.png',
    'assets/social3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // left align
      children: [
        // Row of images
        SizedBox(
          height: 228,
          child: Row(
            children: List.generate(_socialAssets.length, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 8,
                    right: index == _socialAssets.length - 1 ? 0 : 0,
                  ),
                  child: _SocialTile(asset: _socialAssets[index]),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),

        // Post Your Review Button - left aligned
        SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              // Handle button tap
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEB147D),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: const Text(
              "Post Your Review",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Dot Indicators - left aligned
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // left align
          children: List.generate(
            _socialAssets.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 12 : 8,
              height: _currentIndex == index ? 12 : 8,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? const Color.fromARGB(255, 5, 5, 5)
                    : Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialTile extends StatelessWidget {
  const _SocialTile({required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 143,
        height: 228,
        color: const Color(0xFFF6ECFF),
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          width: 143,
          height: 228,
        ),
      ),
    );
  }
}
