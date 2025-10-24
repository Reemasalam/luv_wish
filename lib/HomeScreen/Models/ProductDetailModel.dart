class ProductDetail {
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

  ProductDetail({
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

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json['id'],
        name: json['name'],
        categoryName: json['categoryName'],
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

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json['id'],
        productId: json['productId'],
        url: json['url'],
        altText: json['altText'] ?? "",
        isMain: json['isMain'] ?? false,
        sortOrder: json['sortOrder'] ?? 0,
      );
}
