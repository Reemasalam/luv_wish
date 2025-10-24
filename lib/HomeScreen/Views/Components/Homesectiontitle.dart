import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle({
    super.key,
    required this.title,
    required this.onSortAsc,
    required this.onSortDesc,
    required this.onSortClear,
    required this.priceRange,
    required this.onPriceChanged,
    required this.onPriceReset,
  });

  final String title;
  final VoidCallback onSortAsc;
  final VoidCallback onSortDesc;
  final VoidCallback onSortClear;
  final Rx<RangeValues?> priceRange;
  final ValueChanged<RangeValues> onPriceChanged;
  final VoidCallback onPriceReset;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.w600)),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Sort by Price",
                            style: GoogleFonts.montserrat(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        ListTile(title: const Text("Low to High"), onTap: () { onSortAsc(); Get.back(); }),
                        ListTile(title: const Text("High to Low"), onTap: () { onSortDesc(); Get.back(); }),
                        ListTile(title: const Text("Clear Sort"), onTap: () { onSortClear(); Get.back(); }),
                      ],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFFAF9F9),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Sort"),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {
                Get.bottomSheet(
                  StatefulBuilder(builder: (context, setState) {
                    RangeValues range =
                        priceRange.value ?? const RangeValues(0, 1000);
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Filter by Price",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 20),
                          RangeSlider(
                            values: range,
                            min: 0,
                            max: 5000,
                            divisions: 100,
                            labels: RangeLabels(
                              "₹${range.start.round()}",
                              "₹${range.end.round()}",
                            ),
                            onChanged: (val) => setState(() => range = val),
                            onChangeEnd: onPriceChanged,
                          ),
                          TextButton(
                            onPressed: onPriceReset,
                            child: const Text("Reset"),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFFAF9F9),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.tune, size: 16),
              label: const Text("Filter"),
            ),
          ],
        )
      ],
    );
  }
}
