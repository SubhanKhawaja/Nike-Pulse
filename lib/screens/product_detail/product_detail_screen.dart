import 'package:flutter/material.dart';
import '../../core/utils/responsive_layout.dart';
import '../../models/product.dart';
import '../../state/app_state.dart';
import '../../widgets/common/rating_badge.dart';
import 'widgets/color_swatch_selector.dart';
import 'widgets/product_image_gallery.dart';
import 'widgets/product_specs_accordion.dart';
import 'widgets/size_selector.dart';
import 'widgets/sticky_cart_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String _selectedSize;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.product.availableSizes.first;
    _selectedColor = widget.product.availableColors.first;
  }

  void _handleAddToCart(BuildContext context) {
    final appState = AppScope.of(context);
    appState.cartController.addToCart(
      widget.product,
      _selectedSize,
      _selectedColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} ($_selectedSize) added to your Bag!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = !ResponsiveLayout.isMobile(context);

    return Scaffold(
      body: isWide
          ? _WideDetailView(
              product: widget.product,
              selectedSize: _selectedSize,
              selectedColor: _selectedColor,
              onSizeSelected: (s) => setState(() => _selectedSize = s),
              onColorSelected: (c) => setState(() => _selectedColor = c),
              onAddToCart: () => _handleAddToCart(context),
            )
          : _MobileDetailView(
              product: widget.product,
              selectedSize: _selectedSize,
              selectedColor: _selectedColor,
              onSizeSelected: (s) => setState(() => _selectedSize = s),
              onColorSelected: (c) => setState(() => _selectedColor = c),
            ),
      bottomNavigationBar: isWide
          ? null
          : StickyCartBar(
              product: widget.product,
              onAddToCart: () => _handleAddToCart(context),
            ),
    );
  }
}

class _MobileDetailView extends StatelessWidget {
  final Product product;
  final String selectedSize;
  final Color selectedColor;
  final ValueChanged<String> onSizeSelected;
  final ValueChanged<Color> onColorSelected;

  const _MobileDetailView({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    required this.onSizeSelected,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ProductImageGallery(product: product),
        Padding(
          padding: const EdgeInsets.all(20),
          child: _ProductDetailContent(
            product: product,
            selectedSize: selectedSize,
            selectedColor: selectedColor,
            onSizeSelected: onSizeSelected,
            onColorSelected: onColorSelected,
          ),
        ),
      ],
    );
  }
}

class _WideDetailView extends StatelessWidget {
  final Product product;
  final String selectedSize;
  final Color selectedColor;
  final ValueChanged<String> onSizeSelected;
  final ValueChanged<Color> onColorSelected;
  final VoidCallback onAddToCart;

  const _WideDetailView({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    required this.onSizeSelected,
    required this.onColorSelected,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContentWrapper(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ProductImageGallery(product: product),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductDetailContent(
                    product: product,
                    selectedSize: selectedSize,
                    selectedColor: selectedColor,
                    onSizeSelected: onSizeSelected,
                    onColorSelected: onColorSelected,
                  ),
                  const SizedBox(height: 24),
                  StickyCartBar(product: product, onAddToCart: onAddToCart),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  final Product product;
  final String selectedSize;
  final Color selectedColor;
  final ValueChanged<String> onSizeSelected;
  final ValueChanged<Color> onColorSelected;

  const _ProductDetailContent({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    required this.onSizeSelected,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.tag,
              style: TextStyle(fontSize: 13, color: theme.colorScheme.secondary, fontWeight: FontWeight.w700),
            ),
            RatingBadge(rating: product.rating, reviewCount: product.reviewCount),
          ],
        ),
        const SizedBox(height: 6),
        Text(product.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        Text(
          product.description,
          style: TextStyle(fontSize: 14, height: 1.5, color: theme.colorScheme.onSurface.withAlpha(200)),
        ),
        const SizedBox(height: 20),
        ColorSwatchSelector(
          colors: product.availableColors,
          selectedColor: selectedColor,
          onColorSelected: onColorSelected,
        ),
        const SizedBox(height: 20),
        SizeSelector(
          sizes: product.availableSizes,
          selectedSize: selectedSize,
          onSizeSelected: onSizeSelected,
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 12),
        const ProductSpecsAccordion(),
      ],
    );
  }
}
