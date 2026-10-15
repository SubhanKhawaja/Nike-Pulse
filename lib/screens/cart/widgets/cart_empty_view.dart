import 'package:flutter/material.dart';
import '../../../widgets/common/app_button.dart';

class CartEmptyView extends StatelessWidget {
  final VoidCallback onStartShopping;

  const CartEmptyView({super.key, required this.onStartShopping});

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
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Bag is Empty',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore the latest sneaker drops and add items to your cart.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Explore Drops',
              icon: Icons.arrow_forward_rounded,
              onPressed: onStartShopping,
            ),
          ],
        ),
      ),
    );
  }
}
