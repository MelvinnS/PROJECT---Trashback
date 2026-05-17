// lib/models/product_model.dart

class StoreInfo {
  final String storeName;
  final String storeProfileImage;
  final int totalSales;

  const StoreInfo({
    required this.storeName,
    required this.storeProfileImage,
    required this.totalSales,
  });
}

class Product {
  final String id;
  final String name;
  final double price;
  final double originalPrice; // harga sebelum diskon
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final StoreInfo storeInfo;
  final String? badge; // contoh: 'Flash Sale', 'Terlaris'
  final int? discountPercent;
  final bool isFreeShipping;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.storeInfo,
    this.badge,
    this.discountPercent,
    this.isFreeShipping = false,
  });

  // Salin produk dengan properti yang diubah
  Product copyWith({
    String? id,
    String? name,
    double? price,
    double? originalPrice,
    String? description,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    StoreInfo? storeInfo,
    String? badge,
    int? discountPercent,
    bool? isFreeShipping,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      storeInfo: storeInfo ?? this.storeInfo,
      badge: badge ?? this.badge,
      discountPercent: discountPercent ?? this.discountPercent,
      isFreeShipping: isFreeShipping ?? this.isFreeShipping,
    );
  }
}
