

import 'package:luve_wish/CartScreen/Model/CartItemModel.dart';

class Cart {
  final List<CartItem> items;
  final double total;
  final int itemCount;

  Cart({
    required this.items,
    required this.total,
    required this.itemCount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      total: (json['total'] as num).toDouble(),
      itemCount: json['itemCount'],
    );
  }
}
