import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
       // color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: Color(0xFF000000), fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0xFFBBBBBB), fontSize: 15),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          icon: Icon(Icons.search, color: Color(0xFFBBBBBB)),
         
        ),
      ),
    );
  }
}
