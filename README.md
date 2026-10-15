# Nike Pulse — Flutter UI Clone
A sleek, production-grade Flutter UI clone of the modern Nike Store app covering 5+ complete screens, responsive layouts, smooth transitions, and dynamic light/dark theme toggle — built using **only core Flutter widgets**.

---

## 🌟 Key Features
- **5 Comprehensive Screens**:
  1. **Discover (Home)**: Hero promo banner, categories, trending kicks, member specials, new arrivals.
  2. **Catalog / Explore**: Live search, category filtering, result counters, responsive product grid.
  3. **Product Detail**: Smooth Hero image transition, color swatches, shoe size selector, specifications accordion, sticky "Add to Bag" bar.
  4. **Cart & Checkout**: Quantity controls, promo code engine (`NIKE20` for 20% off), subtotal/tax/shipping calculations, checkout sheet, and order confirmation.
  5. **Profile & Settings**: Member status badge, stats row, light/dark/system theme mode card, settings list, and sign-out.
  6. **Saved / Wishlist**: Instant heart-toggle favorite saving with empty state fallback.
- **Core Widgets Only**: No third-party UI dependencies! Uses Material 3, `InheritedNotifier`, `ChangeNotifier`, `Hero`, `LayoutBuilder`, and `PageRouteBuilder`.
- **Strict Architecture Rule**: Zero build methods exceeding 50 lines (fully verified via automated AST script).
- **Responsive Design**: `MediaQuery` + `LayoutBuilder` adaptive design (mobile `NavigationBar` vs desktop `NavigationRail`, 2-column to 5-column responsive grids).
- **Light & Dark Mode**: Persistent toggle in top AppBar and in Profile settings.
- **Smooth Page Transitions**: Custom `PageRouteBuilder` slide-and-fade transitions with Hero animations.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10+ / 3.38+ supported)
- Dart SDK 3.10+

### Run Locally
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run static analysis (0 warnings)
flutter analyze

# 3. Run test suite
flutter test

# 4. Run on your desired platform
flutter run -d windows    # Windows Desktop
flutter run -d chrome     # Web
flutter run               # Connected mobile device / emulator
```

---

## 📁 Project Architecture
```
lib/
├── app.dart                       # App entry point, ThemeMode binding & MaterialApp
├── main.dart                      # Execution runner
├── core/
│   ├── theme/
│   │   ├── app_colors.dart        # Nike Volt, charcoal, light/dark color tokens
│   │   ├── app_theme.dart         # Material 3 Light & Dark ThemeData
│   │   └── theme_controller.dart  # ThemeMode state notifier
│   ├── transitions/
│   │   └── page_transitions.dart  # Custom AppPageRoute smooth transitions
│   ├── utils/
│   │   └── responsive_layout.dart # MediaQuery & LayoutBuilder breakpoints
│   └── constants/
│       └── app_constants.dart     # Mock sneaker catalog & metadata
├── models/
│   ├── product.dart               # Product data entity
│   └── cart_item.dart             # Cart item & key model
├── state/
│   ├── app_state.dart             # AppScope & AppState InheritedNotifier
│   └── cart_controller.dart       # Cart state & pricing calculations
├── widgets/
│   ├── common/                    # AppButton, SectionHeader, RatingBadge, etc.
│   ├── product/                   # ProductCard, ProductGrid, CategoryChip
│   ├── layout/                    # ResponsiveScaffold (Rail vs BottomNav)
│   └── cart/                      # CartItemTile, CartSummaryCard
└── screens/
    ├── main_navigation_screen.dart# Main shell with top AppBar and cart badge
    ├── discover/                  # Discover / Home screen
    ├── catalog/                   # Catalog / Search screen
    ├── product_detail/            # Product Detail with Hero transition
    ├── cart/                      # Cart & Checkout screen
    ├── profile/                   # Profile & Theme switcher screen
    └── saved/                     # Wishlist / Saved screen
```

---

## 📄 Submission Documents
- `PROJECT_REPORT.md`: Comprehensive 4-5 page documentation covering all architectural patterns, screen breakdowns, responsive tables, testing results, and recording guide.
