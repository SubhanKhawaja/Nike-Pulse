import 'package:flutter/material.dart';
import '../../models/product.dart';

class AppConstants {
  static const String appName = 'NIKE PULSE';
  static const String appTagline = 'Engineered for Greatness';

  static const List<String> categories = [
    'All',
    'Lifestyle',
    'Running',
    'Basketball',
    'Training',
  ];

  static final List<Product> mockProducts = [
    const Product(
      id: 'prod_1',
      name: 'Air Max Pulse Roam',
      tag: "Men's Road Running Shoes",
      category: 'Running',
      price: 159.99,
      originalPrice: 189.99,
      rating: 4.8,
      reviewCount: 342,
      description:
          'Taking inspiration from the London music scene, the Air Max Pulse brings an underground, resilient touch to the iconic Air Max line. Its point-loaded Air cushioning offers ultimate responsiveness whether running miles or city streets.',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800&auto=format&fit=crop&q=80',
      availableColors: [
        Color(0xFFE22128),
        Color(0xFF1E293B),
        Color(0xFFFFFFFF),
      ],
      availableSizes: ['US 7.5', 'US 8', 'US 8.5', 'US 9', 'US 9.5', 'US 10', 'US 10.5', 'US 11'],
      isNewDrop: true,
      isTrending: true,
    ),
    const Product(
      id: 'prod_2',
      name: 'Dunk Low Retro "Panda"',
      tag: "Men's / Women's Shoes",
      category: 'Lifestyle',
      price: 115.00,
      originalPrice: 130.00,
      rating: 4.9,
      reviewCount: 1205,
      description:
          'Created for the hardwood but taken to the streets, the 80s b-ball icon returns with perfectly shined overlays and classic team colors. Premium leather upper ages to soft perfection with vintage throwback flair.',
      imageUrl:
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&auto=format&fit=crop&q=80',
      availableColors: [
        Color(0xFF111111),
        Color(0xFFFFFFFF),
        Color(0xFF3B82F6),
      ],
      availableSizes: ['US 7', 'US 8', 'US 8.5', 'US 9', 'US 10', 'US 11'],
      isNewDrop: false,
      isTrending: true,
    ),
    const Product(
      id: 'prod_3',
      name: 'Air Zoom Pegasus 41',
      tag: "Road Running Performance",
      category: 'Running',
      price: 140.00,
      originalPrice: 160.00,
      rating: 4.7,
      reviewCount: 520,
      description:
          'Responsive cushioning in the Pegasus provides an energized ride for everyday road running. Experience lighter weight energy return with dual Air Zoom units and a ReactX foam midsole.',
      imageUrl:
          'https://images.unsplash.com/photo-1552346154-21d32810aba3?w=800&auto=format&fit=crop&q=80',
      availableColors: [
        Color(0xFF0F172A),
        Color(0xFFCEFF00),
        Color(0xFFF97316),
      ],
      availableSizes: ['US 8', 'US 8.5', 'US 9', 'US 9.5', 'US 10', 'US 10.5'],
      isNewDrop: true,
      isTrending: false,
    ),
    const Product(
      id: 'prod_4',
      name: 'Air Jordan 1 Low SE',
      tag: "Men's Premium Basketball Shoes",
      category: 'Basketball',
      price: 125.00,
      originalPrice: null,
      rating: 4.9,
      reviewCount: 890,
      description:
          'Inspired by the original 1985 silhouette, the Air Jordan 1 Low delivers a clean, classic look that is familiar yet always fresh. Encapsulated Air-Sole unit provides lightweight cushioning with iconic Wings logo detailing.',
      imageUrl:
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=800&auto=format&fit=crop&q=80',
      availableColors: [
        Color(0xFF991B1B),
        Color(0xFF1E293B),
        Color(0xFFF3F4F6),
      ],
      availableSizes: ['US 7.5', 'US 8', 'US 9', 'US 9.5', 'US 10', 'US 11', 'US 12'],
      isNewDrop: false,
      isTrending: true,
    ),
    const Product(
      id: 'prod_5',
      name: 'Nike Metcon 9 AMP',
      tag: "Men's Workout & Training Shoes",
      category: 'Training',
      price: 150.00,
      originalPrice: 175.00,
      rating: 4.6,
      reviewCount: 230,
      description:
          'Whatever your fitness goals, the Metcon 9 makes it worth the work. An enlarged Hyperlift plate in the heel and added rubber rope wrap are built for weightlifters, cross-trainers, and go-getters.',
      imageUrl:
          'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=800&auto=format&fit=crop&q=80',
      availableColors: [
        Color(0xFF18181B),
        Color(0xFF64748B),
        Color(0xFFCEFF00),
      ],
      availableSizes: ['US 8', 'US 8.5', 'US 9', 'US 10', 'US 10.5'],
      isNewDrop: false,
      isTrending: false,
    ),
    const Product(
      id: 'prod_6',
      name: 'Air Force 1 07 Fresh',
      tag: "Iconic Streetwear Classic",
      category: 'Lifestyle',
      price: 130.00,
      originalPrice: 145.00,
      rating: 4.9,
      reviewCount: 2450,
      description:
          'The radiance lives on in the Air Force 1 07 Fresh. Easy-to-clean soft leather helps keep your kicks looking crisp, while perforated sockliner keeps airflow breezy and all-day comfort steady.',
      imageUrl:
          'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=800&auto=format&fit=crop&q=80',
      availableColors: [
        Color(0xFFFFFFFF),
        Color(0xFF1E293B),
      ],
      availableSizes: ['US 7', 'US 7.5', 'US 8', 'US 8.5', 'US 9', 'US 9.5', 'US 10', 'US 11'],
      isNewDrop: false,
      isTrending: true,
    ),
  ];
}
