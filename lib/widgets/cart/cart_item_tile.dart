import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/cart_item.dart';
import '../../state/app_state.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ItemThumbnail(imageUrl: item.product.imageUrl),
            const SizedBox(width: 14),
            Expanded(
              child: _ItemInfo(item: item, theme: theme),
            ),
            _ItemQuantityControls(item: item),
          ],
        ),
      ),
    );
  }
}

class _ItemThumbnail extends StatelessWidget {
  final String imageUrl;

  const _ItemThumbnail({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 76,
        height: 76,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurfaceAlt
            : AppColors.lightSurfaceAlt,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_rounded, size: 28),
        ),
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  final CartItem item;
  final ThemeData theme;

  const _ItemInfo({required this.item, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              item.selectedSize,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withAlpha(160),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: item.selectedColor,
                shape: BoxShape.circle,
                border: Border.all(color: theme.colorScheme.outline, width: 0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '\$${item.totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        ),
      ],
    );
  }
}

class _ItemQuantityControls extends StatelessWidget {
  final CartItem item;

  const _ItemQuantityControls({required this.item});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurfaceAlt
            : AppColors.lightSurfaceAlt,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: () =>
                appState.cartController.updateQuantity(item, item.quantity - 1),
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: () =>
                appState.cartController.updateQuantity(item, item.quantity + 1),
          ),
        ],
      ),
    );
  }
}
