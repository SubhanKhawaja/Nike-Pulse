import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/transitions/page_transitions.dart';
import '../../core/utils/responsive_layout.dart';
import '../../models/product.dart';
import '../../state/app_state.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/product/product_grid.dart';
import '../product_detail/product_detail_screen.dart';
import 'widgets/catalog_filter_bar.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _getFilteredProducts(AppState state) {
    return AppConstants.mockProducts.where((p) {
      final matchesCategory = state.selectedCategory == 'All' || p.category == state.selectedCategory;
      final query = state.searchQuery.toLowerCase().trim();
      final matchesSearch = query.isEmpty ||
          p.name.toLowerCase().contains(query) ||
          p.tag.toLowerCase().contains(query) ||
          p.category.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _openDetail(BuildContext context, Product product) {
    Navigator.of(context).push(AppPageRoute.slideRight(ProductDetailScreen(product: product)));
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final filtered = _getFilteredProducts(appState);

    return ResponsiveContentWrapper(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: CustomSearchBar(
              controller: _searchController,
              hintText: 'Search in catalog...',
              onChanged: (val) => appState.setSearchQuery(val),
            ),
          ),
          CatalogFilterBar(
            selectedCategory: appState.selectedCategory,
            onCategoryChanged: (cat) => appState.setSelectedCategory(cat),
            resultCount: filtered.length,
          ),
          Expanded(
            child: filtered.isEmpty
                ? _EmptySearchResults(
                    onReset: () {
                      _searchController.clear();
                      appState.setSearchQuery('');
                      appState.setSelectedCategory('All');
                    },
                  )
                : ProductGrid(
                    products: filtered,
                    onProductTap: (product) => _openDetail(context, product),
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptySearchResults extends StatelessWidget {
  final VoidCallback onReset;

  const _EmptySearchResults({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No matching sneakers found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your search query or category filters.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onReset,
              child: const Text('Reset All Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
