import 'package:flutter/material.dart';

class ProductSpecsAccordion extends StatelessWidget {
  const ProductSpecsAccordion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SpecTile(
          icon: Icons.local_shipping_outlined,
          title: 'Free Delivery & Returns',
          subtitle: 'Standard delivery in 3-5 working days. 30-day return policy.',
        ),
        _SpecTile(
          icon: Icons.verified_user_outlined,
          title: '100% Authentic Guarantee',
          subtitle: 'Verified authentic by Nike certified specialists.',
        ),
        _SpecTile(
          icon: Icons.eco_outlined,
          title: 'Sustainable Materials',
          subtitle: 'Made with at least 20% recycled content by weight.',
        ),
      ],
    );
  }
}

class _SpecTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SpecTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.secondary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withAlpha(160),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
