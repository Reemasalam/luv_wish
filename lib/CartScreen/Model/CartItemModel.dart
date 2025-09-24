

import 'package:luve_wish/CartScreen/Model/CartProductModel.dart';

class CartItem {
  final String id;
  final String userId;
  final String productId;
  final int quantity;
  final String createdAt;
  final String updatedAt;
  final String? customerProfileId;
  final CartProduct product;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    this.customerProfileId,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      quantity: json['quantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      customerProfileId: json['customerProfileId'],
      product: CartProduct.fromJson(json['product']),
    );
  }
}
