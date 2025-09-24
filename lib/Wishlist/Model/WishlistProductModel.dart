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

class Product {
  final String id;
  final String name;
  final String categoryName;
  final double discountedPrice;
  final double actualPrice;
  final String description;
  final int stockCount;
  final bool isStock;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.discountedPrice,
    required this.actualPrice,
    required this.description,
    required this.stockCount,
    required this.isStock,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      categoryName: json['categoryName'] ?? "",
      discountedPrice: double.tryParse(json['discountedPrice'].toString()) ?? 0,
      actualPrice: double.tryParse(json['actualPrice'].toString()) ?? 0,
      description: json['description'] ?? "",
      stockCount: json['stockCount'] ?? 0,
      isStock: json['isStock'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}
