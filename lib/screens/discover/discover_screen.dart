import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/transitions/page_transitions.dart';
import '../../core/utils/responsive_layout.dart';
import '../../models/product.dart';
import '../../state/app_state.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/common/section_header.dart';
import '../product_detail/product_detail_screen.dart';
import 'widgets/banner_deal_card.dart';
import 'widgets/category_selector.dart';
import 'widgets/hero_promo_carousel.dart';
import 'widgets/trending_products_row.dart';

class DiscoverScreen extends StatelessWidget {
  final VoidCallback onNavigateToCatalog;

  const DiscoverScreen({super.key, required this.onNavigateToCatalog});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContentWrapper(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          _DiscoverTopSection(onNavigateToCatalog: onNavigateToCatalog),
          _DiscoverProductsSection(onNavigateToCatalog: onNavigateToCatalog),
        ],
      ),
    );
  }
}

class _DiscoverTopSection extends StatelessWidget {
  final VoidCallback onNavigateToCatalog;

  const _DiscoverTopSection({required this.onNavigateToCatalog});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: CustomSearchBar(
            readOnly: true,
            onTap: onNavigateToCatalog,
            onFilterTap: onNavigateToCatalog,
          ),
        ),
        HeroPromoCarousel(onShopNow: onNavigateToCatalog),
        const SizedBox(height: 12),
        CategorySelector(
          selectedCategory: appState.selectedCategory,
          onCategorySelected: (cat) {
            appState.setSelectedCategory(cat);
            onNavigateToCatalog();
          },
        ),
      ],
    );
  }
}

class _DiscoverProductsSection extends StatelessWidget {
  final VoidCallback onNavigateToCatalog;

  const _DiscoverProductsSection({required this.onNavigateToCatalog});

  void _openProduct(BuildContext context, Product product) {
    Navigator.of(context).push(AppPageRoute.slideRight(ProductDetailScreen(product: product)));
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final trending = AppConstants.mockProducts.where((p) => p.isTrending).toList();
    final newDrops = AppConstants.mockProducts.where((p) => p.isNewDrop).toList();

    return Column(
      children: [
        const SizedBox(height: 16),
        SectionHeader(
          title: 'Trending Drops',
          subtitle: 'The hottest kicks on the street right now',
          actionLabel: 'See All',
          onActionTap: onNavigateToCatalog,
        ),
        TrendingProductsRow(
          products: trending,
          onProductTap: (product) => _openProduct(context, product),
        ),
        BannerDealCard(
          onClaimDeal: () {
            appState.cartController.applyPromoCode('NIKE20');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Promo code NIKE20 (20% off) applied!')),
            );
          },
        ),
        SectionHeader(
          title: 'New Releases',
          subtitle: 'Fresh silhouettes just arrived',
          actionLabel: 'View All',
          onActionTap: onNavigateToCatalog,
        ),
        TrendingProductsRow(
          products: newDrops,
          onProductTap: (product) => _openProduct(context, product),
        ),
      ],
    );
  }
}
