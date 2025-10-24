import '../../HomeScreen/Models/ProductModel.dart';

class WishlistProduct {
  final String wishlistId; // id of the wishlist entry
  final String customerProfileId;
  final String? productId;
  final Product? product;

  WishlistProduct({
    required this.wishlistId,
    required this.customerProfileId,
    this.productId,
    this.product,
  });

  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    return WishlistProduct(
      wishlistId: json['id'] ?? "",
      customerProfileId: json['customerProfileId'] ?? "",
      productId: json['productId'],
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
    );
  }
}

