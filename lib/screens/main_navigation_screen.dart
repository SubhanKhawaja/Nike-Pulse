import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../state/app_state.dart';
import '../../widgets/common/theme_toggle_button.dart';
import '../../widgets/layout/responsive_scaffold.dart';
import 'cart/cart_screen.dart';
import 'catalog/catalog_screen.dart';
import 'discover/discover_screen.dart';
import 'profile/profile_screen.dart';
import 'saved/saved_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _navigateToIndex(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final cartCount = appState.cartController.itemCount;

    final screens = [
      DiscoverScreen(onNavigateToCatalog: () => _navigateToIndex(1)),
      const CatalogScreen(),
      CartScreen(onNavigateToCatalog: () => _navigateToIndex(1)),
      SavedScreen(onExplore: () => _navigateToIndex(1)),
      const ProfileScreen(),
    ];

    return ResponsiveScaffold(
      currentIndex: _currentIndex,
      onIndexChanged: _navigateToIndex,
      screens: screens,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.flash_on_rounded, color: AppColors.accentOrange, size: 24),
            SizedBox(width: 8),
            Text(
              AppConstants.appName,
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.0, fontSize: 18),
            ),
          ],
        ),
        actions: [
          const ThemeToggleButton(),
          _CartBadgeButton(
            cartCount: cartCount,
            onPressed: () => _navigateToIndex(2),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _CartBadgeButton extends StatelessWidget {
  final int cartCount;
  final VoidCallback onPressed;

  const _CartBadgeButton({required this.cartCount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined),
          tooltip: 'Shopping Bag',
          onPressed: onPressed,
        ),
        if (cartCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.accentOrange,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$cartCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
