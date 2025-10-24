import 'package:flutter/material.dart';

class HomeReviewCard extends StatelessWidget {
  const HomeReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Genuine Stories, Remarkable Relief",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEAEAEA)),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _StarsRow(),
              SizedBox(height: 8),
              Text(
                "Krishna Priya",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              Text(
                "I'm an independent student in Australia and honestly, I'm surviving university and work because of your period pain relief patch! Without it, I couldn't be out for long hours. I love everything about your product! The only issue is international delivery - I have to rely on someone coming from India to bring them. Keep doing what you're doing. Lots of love for Luvwish",
                style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StarsRow extends StatelessWidget {
  const _StarsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (i) => const Padding(
          padding: EdgeInsets.only(right: 4.0),
          child: Icon(Icons.star, size: 18, color: Color(0xFFFFC107)),
        ),
      ),
    );
  }
}
