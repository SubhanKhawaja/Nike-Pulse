import 'package:flutter/material.dart';

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: const [
          _SettingsTile(
            icon: Icons.receipt_long_outlined,
            title: 'Order History',
            subtitle: 'View recent purchases and track parcels',
          ),
          Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.location_on_outlined,
            title: 'Saved Addresses',
            subtitle: 'Default delivery location',
          ),
          Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.payment_outlined,
            title: 'Payment Methods',
            subtitle: 'Credit cards, Apple Pay, PayPal',
          ),
          Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            subtitle: 'New drop alerts & order status',
          ),
          Divider(height: 1, indent: 56),
          _SettingsTile(
            icon: Icons.help_outline_rounded,
            title: 'Help & Customer Support',
            subtitle: 'FAQs, live chat, contact us',
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.secondary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: theme.colorScheme.onSurface.withAlpha(150),
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: () {},
    );
  }
}
