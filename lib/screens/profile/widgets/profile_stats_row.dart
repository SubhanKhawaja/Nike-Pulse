import 'package:flutter/material.dart';
import '../../../state/app_state.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final favCount = appState.favoriteProductIds.length;
    final cartCount = appState.cartController.itemCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _StatCard(title: 'Saved Items', value: '$favCount', icon: Icons.favorite_border_rounded),
          const SizedBox(width: 12),
          _StatCard(title: 'In Cart', value: '$cartCount', icon: Icons.shopping_bag_outlined),
          const SizedBox(width: 12),
          const _StatCard(title: 'Passes', value: '4', icon: Icons.qr_code_rounded),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Column(
            children: [
              Icon(icon, size: 20, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(height: 6),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 2),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
