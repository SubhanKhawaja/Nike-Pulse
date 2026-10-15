import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/transitions/page_transitions.dart';
import '../../core/utils/responsive_layout.dart';
import '../../models/product.dart';
import '../../state/app_state.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/product/product_grid.dart';
import '../product_detail/product_detail_screen.dart';

class SavedScreen extends StatelessWidget {
  final VoidCallback onExplore;

  const SavedScreen({super.key, required this.onExplore});

  void _openDetail(BuildContext context, Product product) {
    Navigator.of(context).push(AppPageRoute.slideRight(ProductDetailScreen(product: product)));
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final savedProducts = AppConstants.mockProducts
        .where((p) => appState.isFavorite(p.id))
        .toList();

    return ResponsiveContentWrapper(
      child: savedProducts.isEmpty
          ? _EmptySavedView(onExplore: onExplore)
          : ProductGrid(
              products: savedProducts,
              onProductTap: (product) => _openDetail(context, product),
            ),
    );
  }
}

class _EmptySavedView extends StatelessWidget {
  final VoidCallback onExplore;

  const _EmptySavedView({required this.onExplore});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.favorite_border_rounded, size: 64, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Saved Sneakers',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the heart icon on any shoe to save it to your wishlist.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Explore Catalog',
              icon: Icons.search_rounded,
              onPressed: onExplore,
            ),
          ],
        ),
      ),
    );
  }
}
