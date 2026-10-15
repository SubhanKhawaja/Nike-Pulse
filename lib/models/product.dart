import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String tag;
  final String category;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewCount;
  final String description;
  final String imageUrl;
  final List<Color> availableColors;
  final List<String> availableSizes;
  final bool isNewDrop;
  final bool isTrending;

  const Product({
    required this.id,
    required this.name,
    required this.tag,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.imageUrl,
    required this.availableColors,
    required this.availableSizes,
    this.isNewDrop = false,
    this.isTrending = false,
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  int get discountPercent {
    if (!hasDiscount) return 0;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }
}
