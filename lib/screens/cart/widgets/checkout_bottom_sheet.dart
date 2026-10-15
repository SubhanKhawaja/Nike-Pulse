import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../state/app_state.dart';
import '../../../widgets/common/app_button.dart';

class CheckoutBottomSheet extends StatelessWidget {
  final VoidCallback onOrderCompleted;

  const CheckoutBottomSheet({super.key, required this.onOrderCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _CheckoutHeader(),
          const SizedBox(height: 12),
          const _CheckoutInfoTile(
            icon: Icons.location_on_outlined,
            title: 'Delivery Address',
            subtitle: '742 Evergreen Terrace, Springfield, OR',
          ),
          const SizedBox(height: 8),
          const _CheckoutInfoTile(
            icon: Icons.credit_card_rounded,
            title: 'Payment Method',
            subtitle: 'Apple Pay / Visa ending in •••• 4242',
          ),
          const SizedBox(height: 16),
          _CheckoutPaymentSummary(onOrderCompleted: onOrderCompleted),
        ],
      ),
    );
  }
}

class _CheckoutHeader extends StatelessWidget {
  const _CheckoutHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Checkout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _CheckoutPaymentSummary extends StatelessWidget {
  final VoidCallback onOrderCompleted;

  const _CheckoutPaymentSummary({required this.onOrderCompleted});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final cart = appState.cartController;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            Text(
              '\$${cart.grandTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Place Order Now',
          icon: Icons.check_circle_outline_rounded,
          isFullWidth: true,
          onPressed: () {
            Navigator.of(context).pop();
            cart.clearCart();
            onOrderCompleted();
          },
        ),
      ],
    );
  }
}

class _CheckoutInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CheckoutInfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppColors.darkSurfaceAlt
            : AppColors.lightSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, size: 18),
        ],
      ),
    );
  }
}
