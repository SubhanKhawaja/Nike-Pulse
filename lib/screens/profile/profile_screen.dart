import 'package:flutter/material.dart';
import '../../core/utils/responsive_layout.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/profile_settings_list.dart';
import 'widgets/profile_stats_row.dart';
import 'widgets/theme_mode_selector_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContentWrapper(
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 32),
        children: [
          const ProfileHeaderCard(),
          const ProfileStatsRow(),
          const ThemeModeSelectorCard(),
          const ProfileSettingsList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out of Nike Member account')),
                );
              },
              icon: const Icon(Icons.logout_rounded, size: 18),
              label: const Text('Sign Out'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ),
          Center(
            child: Text(
              'Nike Pulse v1.0.0 (Build 2026.1)',
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
