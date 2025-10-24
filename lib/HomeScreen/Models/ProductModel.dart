class Product {
  final String id;
  final String name;
  final String categoryName;
  final double discountedPrice; // selling price
  final double actualPrice;     // original price
  final String description;
  final int stockCount;
  final bool isStock;
  final List<ProductImage> images;
  final double rating; // e.g., 4.5
  final int reviewCount; // e.g., 120

  Product({
    required this.id,
    required this.name,
    required this.categoryName,
    required this.discountedPrice,
    required this.actualPrice,
    required this.description,
    required this.stockCount,
    required this.isStock,
    required this.images,
    required this.rating,
    required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      categoryName: json["categoryName"] ?? "",
      discountedPrice: double.tryParse(json["discountedPrice"]?.toString() ?? "0") ?? 0,
      actualPrice: double.tryParse(json["actualPrice"]?.toString() ?? "0") ?? 0,
      description: json["description"] ?? "",
      stockCount: json["stockCount"] ?? 0,
      isStock: json["isStock"] ?? false,
      rating: double.tryParse(json["rating"]?.toString() ?? "0") ?? 0,
      reviewCount: json["reviewCount"] ?? 0,
      images: (json["images"] as List? ?? [])
          .map((e) => ProductImage.fromJson(e))

          .toList(),
    );
  }

  toJson() {}
}

class ProductImage {
  final String id;
  final String url;
  final String altText;
  final bool isMain;

  ProductImage({
    required this.id,
    required this.url,
    required this.altText,
    required this.isMain,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json["id"] ?? "",
      url: json["url"] ?? "",
      altText: json["altText"] ?? "",
      isMain: json["isMain"] ?? false,
    );
  }
}


class Category {
  final String id;
  final String name;
  final String description;
  final String image;
  final bool isActive;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }
}


class Inventory {
  final String id;
  final int quantity;
  final int reserved;
  final String? location;

  Inventory({
    required this.id,
    required this.quantity,
    required this.reserved,
    this.location,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id']?.toString() ?? '',
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      reserved: int.tryParse(json['reserved']?.toString() ?? '0') ?? 0,
      location: json['location'],
    );
  }
}
