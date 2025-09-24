class CartProduct {
  final String id;
  final String name;
  final String description;
  final String price;
  final String comparePrice;
  final String sku;
  final String barcode;
  final String weight;
  final String dimensions;
  final bool isActive;
  final bool isFeatured;
  final String categoryId;
  final String brandId;
  final String createdAt;
  final String updatedAt;
  final List<ProductImage> images;
  final List<ProductInventory> inventory;

  CartProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.comparePrice,
    required this.sku,
    required this.barcode,
    required this.weight,
    required this.dimensions,
    required this.isActive,
    required this.isFeatured,
    required this.categoryId,
    required this.brandId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.inventory,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      comparePrice: json['comparePrice'],
      sku: json['sku'],
      barcode: json['barcode'],
      weight: json['weight'],
      dimensions: json['dimensions'],
      isActive: json['isActive'],
      isFeatured: json['isFeatured'],
      categoryId: json['categoryId'],
      brandId: json['brandId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      images: (json['images'] as List)
          .map((e) => ProductImage.fromJson(e))
          .toList(),
      inventory: (json['inventory'] as List)
          .map((e) => ProductInventory.fromJson(e))
          .toList(),
    );
  }
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
      productId: json['productId'],
      url: json['url'],
      altText: json['altText'],
      isMain: json['isMain'],
      sortOrder: json['sortOrder'],
    );
  }
}

class ProductInventory {
  final String id;
  final String productId;
  final int quantity;
  final int reserved;
  final String? location;

  ProductInventory({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.reserved,
    this.location,
  });

  factory ProductInventory.fromJson(Map<String, dynamic> json) {
    return ProductInventory(
      id: json['id'],
      productId: json['productId'],
      quantity: json['quantity'],
      reserved: json['reserved'],
      location: json['location'],
    );
  }
}
