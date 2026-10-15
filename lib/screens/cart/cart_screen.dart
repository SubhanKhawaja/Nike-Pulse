import 'package:flutter/material.dart';
import '../../core/utils/responsive_layout.dart';
import '../../state/app_state.dart';
import '../../widgets/cart/cart_item_tile.dart';
import '../../widgets/cart/cart_summary_card.dart';
import 'widgets/cart_empty_view.dart';
import 'widgets/checkout_bottom_sheet.dart';
import 'widgets/promo_code_input.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback onNavigateToCatalog;

  const CartScreen({super.key, required this.onNavigateToCatalog});

  void _showCheckout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => CheckoutBottomSheet(
        onOrderCompleted: () {
          showDialog(
            context: context,
            builder: (dCtx) => AlertDialog(
              icon: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 54),
              title: const Text('Order Confirmed!'),
              content: const Text(
                'Thank you for your purchase. Your order #NK-82914 has been placed and will ship in 2-3 business days.',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dCtx).pop(),
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final cart = appState.cartController;
    final isWide = !ResponsiveLayout.isMobile(context);

    if (cart.items.isEmpty) {
      return CartEmptyView(onStartShopping: onNavigateToCatalog);
    }

    return ResponsiveContentWrapper(
      child: isWide
          ? _WideCartView(
              onCheckout: () => _showCheckout(context),
            )
          : _MobileCartView(
              onCheckout: () => _showCheckout(context),
            ),
    );
  }
}

class _MobileCartView extends StatelessWidget {
  final VoidCallback onCheckout;

  const _MobileCartView({required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final cart = appState.cartController;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        ...cart.items.map((item) => CartItemTile(key: ValueKey(item.uniqueKey), item: item)),
        const SizedBox(height: 12),
        const PromoCodeInput(),
        const SizedBox(height: 8),
        CartSummaryCard(onCheckout: onCheckout),
      ],
    );
  }
}

class _WideCartView extends StatelessWidget {
  final VoidCallback onCheckout;

  const _WideCartView({required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final cart = appState.cartController;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              ...cart.items.map((item) => CartItemTile(key: ValueKey(item.uniqueKey), item: item)),
              const PromoCodeInput(),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: CartSummaryCard(onCheckout: onCheckout),
          ),
        ),
      ],
    );
  }
}
