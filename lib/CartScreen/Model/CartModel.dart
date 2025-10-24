class CartModel {
  final bool success;
  final List<CartItem> data;

  CartModel({required this.success, required this.data});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  factory CartModel.empty() => CartModel(success: false, data: []);
}

class CartItem {
  final String id;
  final String? productId;
  final int? quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String customerProfileId;
  final Product? product;

  CartItem({
    required this.id,
    this.productId,
    this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.customerProfileId,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      customerProfileId: json['customerProfileId'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  // Safe helpers
  int get qty => quantity ?? 1;
  double get unitPrice => product?.effectivePrice ?? 0;
  double get lineTotal => unitPrice * qty;
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductImage> images;

  Product({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.discountedPrice,
    required this.actualPrice,
    required this.description,
    required this.stockCount,
    required this.isStock,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? "",
      categoryName: json['categoryName'] ?? "",
      discountedPrice: double.tryParse(json['discountedPrice'].toString()) ?? 0,
      actualPrice: double.tryParse(json['actualPrice'].toString()) ?? 0,
      description: json['description'] ?? "",
      stockCount: json['stockCount'] ?? 0,
      isStock: json['isStock'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e))
              .toList() ??
          [],
    );
  }

  // Use discounted price if available, else fall back to actual price
  double get effectivePrice => discountedPrice > 0 ? discountedPrice : actualPrice;
}

class ProductImage {
  final String id;
  final String productId;
  final String url;
  final String altText;
  final bool isMain;
  final int sortOrder;

  ProductImage({
    required this.id,
    required this.productId,
    required this.url,
    required this.altText,
    required this.isMain,
    required this.sortOrder,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['productId'] ?? "",
      url: json['url'] ?? "",
      altText: json['altText'] ?? "",
      isMain: json['isMain'] ?? false,
      sortOrder: json['sortOrder'] ?? 0,
    );
  }
}
