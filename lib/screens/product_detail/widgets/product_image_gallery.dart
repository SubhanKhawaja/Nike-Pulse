import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/product.dart';
import '../../../state/app_state.dart';

class ProductImageGallery extends StatelessWidget {
  final Product product;

  const ProductImageGallery({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final isFav = appState.isFavorite(product.id);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 380,
      width: double.infinity,
      color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'product_image_${product.id}',
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image_rounded, size: 64, color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: _CircleIconButton(
              icon: Icons.arrow_back_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: _CircleIconButton(
              icon: isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: isFav ? AppColors.accentOrange : null,
              onPressed: () => appState.toggleFavorite(product.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const _CircleIconButton({required this.icon, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(90),
      shape: const CircleBorder(),
      child: IconButton(
        icon: Icon(icon, color: color ?? Colors.white, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
