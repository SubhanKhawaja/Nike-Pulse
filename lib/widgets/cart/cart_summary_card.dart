import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../state/app_state.dart';
import '../common/app_button.dart';

class CartSummaryCard extends StatelessWidget {
  final VoidCallback onCheckout;

  const CartSummaryCard({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final cart = appState.cartController;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            const _OrderCostBreakdown(),
            const SizedBox(height: 20),
            AppButton(
              label: 'Proceed to Checkout',
              icon: Icons.lock_outline_rounded,
              isFullWidth: true,
              onPressed: cart.items.isEmpty ? null : onCheckout,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCostBreakdown extends StatelessWidget {
  const _OrderCostBreakdown();

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final cart = appState.cartController;

    return Column(
      children: [
        _SummaryRow(label: 'Subtotal', value: '\$${cart.subtotal.toStringAsFixed(2)}'),
        if (cart.discountAmount > 0)
          _SummaryRow(
            label: 'Promo Discount (${(cart.promoDiscountPercent * 100).toInt()}%)',
            value: '-\$${cart.discountAmount.toStringAsFixed(2)}',
            valueColor: AppColors.success,
          ),
        _SummaryRow(
          label: 'Estimated Shipping',
          value: cart.shippingFee == 0 ? 'FREE' : '\$${cart.shippingFee.toStringAsFixed(2)}',
          valueColor: cart.shippingFee == 0 ? AppColors.success : null,
        ),
        _SummaryRow(
          label: 'Estimated Tax',
          value: '\$${cart.estimatedTax.toStringAsFixed(2)}',
        ),
        const Divider(height: 24),
        _SummaryRow(
          label: 'Total',
          value: '\$${cart.grandTotal.toStringAsFixed(2)}',
          isBold: true,
          fontSize: 18,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double fontSize;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.fontSize = 14,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontWeight = isBold ? FontWeight.w800 : FontWeight.w500;
    final color = valueColor ?? (isBold ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.withAlpha(200));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: theme.colorScheme.onSurface.withAlpha(180),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
