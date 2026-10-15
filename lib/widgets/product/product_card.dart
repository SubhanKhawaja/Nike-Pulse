import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/product.dart';
import '../../state/app_state.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _ProductImageSection(product: product),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _ProductDetailsSection(product: product),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImageSection extends StatelessWidget {
  final Product product;

  const _ProductImageSection({required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
          child: Hero(
            tag: 'product_image_${product.id}',
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image_rounded, size: 40, color: Colors.grey),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _ProductCardFavButton(productId: product.id),
        ),
        if (product.hasDiscount)
          Positioned(
            top: 8,
            left: 8,
            child: _ProductCardDiscountBadge(discountPercent: product.discountPercent),
          ),
      ],
    );
  }
}

class _ProductCardFavButton extends StatelessWidget {
  final String productId;

  const _ProductCardFavButton({required this.productId});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final isFav = appState.isFavorite(productId);

    return Material(
      color: Colors.black.withAlpha(90),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => appState.toggleFavorite(productId),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            size: 16,
            color: isFav ? AppColors.accentOrange : Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ProductCardDiscountBadge extends StatelessWidget {
  final int discountPercent;

  const _ProductCardDiscountBadge({required this.discountPercent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentOrange,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '-$discountPercent%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ProductDetailsSection extends StatelessWidget {
  final Product product;

  const _ProductDetailsSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ProductCardTitleAndTag(tag: product.tag, name: product.name),
        _ProductCardPriceAndRating(product: product),
      ],
    );
  }
}

class _ProductCardTitleAndTag extends StatelessWidget {
  final String tag;
  final String name;

  const _ProductCardTitleAndTag({required this.tag, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ],
    );
  }
}

class _ProductCardPriceAndRating extends StatelessWidget {
  final Product product;

  const _ProductCardPriceAndRating({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              ),
              if (product.originalPrice != null) ...[
                const SizedBox(width: 4),
                Text(
                  '\$${product.originalPrice!.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough,
                    color: theme.colorScheme.onSurface.withAlpha(120),
                  ),
                ),
              ],
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, size: 14, color: AppColors.starGold),
            const SizedBox(width: 2),
            Text(
              product.rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
