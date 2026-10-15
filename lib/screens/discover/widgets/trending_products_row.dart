import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../widgets/product/product_card.dart';

class TrendingProductsRow extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onProductTap;

  const TrendingProductsRow({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 190,
            margin: const EdgeInsets.only(right: 14),
            child: ProductCard(
              product: product,
              onTap: () => onProductTap(product),
            ),
          );
        },
      ),
    );
  }
}
