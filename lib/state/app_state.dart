import 'package:flutter/material.dart';
import '../core/theme/theme_controller.dart';
import 'cart_controller.dart';

class AppState extends ChangeNotifier {
  final CartController cartController = CartController();
  final ThemeController themeController = ThemeController();

  final Set<String> _favoriteProductIds = {'prod_1', 'prod_4'};
  String _selectedCategory = 'All';
  String _searchQuery = '';

  AppState() {
    cartController.addListener(_onSubControllerNotification);
    themeController.addListener(_onSubControllerNotification);
  }

  void _onSubControllerNotification() {
    notifyListeners();
  }

  @override
  void dispose() {
    cartController.removeListener(_onSubControllerNotification);
    themeController.removeListener(_onSubControllerNotification);
    cartController.dispose();
    themeController.dispose();
    super.dispose();
  }

  Set<String> get favoriteProductIds => Set.unmodifiable(_favoriteProductIds);
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  bool isFavorite(String productId) => _favoriteProductIds.contains(productId);

  void toggleFavorite(String productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      notifyListeners();
    }
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState appState,
    required super.child,
  }) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final AppScope? scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in context');
    return scope!.notifier!;
  }
}
