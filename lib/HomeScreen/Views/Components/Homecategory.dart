import 'package:flutter/material.dart';

class HomeCategoryStrip extends StatelessWidget {
  const HomeCategoryStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = const [
      {"name": "Sanitary Pads", "image": "assets/pad.png"},
      {"name": "Relief Patch", "image": "assets/patch.png"},
      {"name": "Menstrual Kit", "image": "assets/kit.png"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
          child: Text(
            "Select Categories",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 120, // height to accommodate image + text
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
           // padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEAEAEA)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        category["image"]!,
                        fit: BoxFit.cover, // full image cover
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                 SizedBox( width: 70, child: Text( category["name"]!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12), ), ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
