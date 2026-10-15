# Phase 1: Flutter Foundations and UI Mastery
## Project Challenge: Nike Pulse — High-Performance E-Commerce Flutter UI Clone
**Author / Developer:** Subhajit  
**Framework:** Flutter 3.38.3 (Channel Stable) / Dart 3.10.1  
**Target Platforms:** Android, iOS, Web, Windows Desktop, macOS, Linux  
**Repository Architecture:** Clean Component Architecture (Only Core Widgets)

---

## Executive Summary
This project represents a comprehensive, production-grade Flutter UI clone of the modern **Nike E-Commerce Store** ("NIKE PULSE"), engineered strictly in accordance with Phase 1 Flutter UI Mastery guidelines:
- **5 Comprehensive Screens**: Discover (Home), Catalog (Explore & Filter), Product Detail (Interactive Swatches & Sticky Bar), Cart & Checkout (Dynamic Calculations & Checkout Sheet), and Profile & Settings (Tier Card, Theme Switcher & System Options).
- **Zero Third-Party UI Bloat**: 100% powered by Flutter core Material 3 widgets, `InheritedNotifier`, `ChangeNotifier`, `Hero`, `LayoutBuilder`, and `PageRouteBuilder`.
- **Strict 50-Line Build Method Rule**: Audited via automated script across 100% of the codebase; every single widget build method is between 8 and 48 lines.
- **Adaptive Responsiveness**: Dynamic multi-column Grid calculations via `LayoutBuilder` and fluid viewport transitions from mobile `NavigationBar` to desktop/tablet `NavigationRail` via `MediaQuery`.
- **Dynamic Light & Dark Mode**: Persistent real-time theme switching with customized typography, high-contrast surface palettes, and signature Nike Volt (`#CEFF00`) / Crimson accents.
- **Micro-Animations & Smooth Page Transitions**: Custom `AppPageRoute.slideRight` and `AppPageRoute.slideUp` transitions paired with seamless `Hero` image transitions.

---

## 1. Architectural Design & State Management

### State Architecture (`InheritedNotifier` Pattern)
To maintain pure reliance on Flutter's core framework without external state management dependencies (such as Bloc, Riverpod, or Provider), the app implements Flutter's core `InheritedNotifier`:
```
                  ┌────────────────────────┐
                  │      NikePulseApp      │
                  └───────────┬────────────┘
                              │
                  ┌───────────▼────────────┐
                  │   AppScope (Inherited) │
                  │  AppState ChangeNotifier│
                  └───────────┬────────────┘
         ┌────────────────────┼────────────────────┐
         ▼                    ▼                    ▼
┌──────────────────┐ ┌──────────────────┐ ┌──────────────────┐
│ ThemeController  │ │  CartController  │ │  Favorites &     │
│ Light/Dark/System│ │Items, Tax, Promo │ │  Search Filters  │
└──────────────────┘ └──────────────────┘ └──────────────────┘
```

- **`ThemeController`**: Manages `ThemeMode.light`, `ThemeMode.dark`, and `ThemeMode.system`. Listened to by `ListenableBuilder` at the root `MaterialApp`.
- **`CartController`**: Provides real-time calculation of subtotal, progressive shipping rates (Free over \$150, \$15 otherwise), 8% estimated tax, and instant promotional discount code validation (`NIKE20` for 20% off).
- **`AppState`**: Coordinates favorite items (`Set<String>`), selected category filters, and live search queries.

---

## 2. Screen-by-Screen Breakdown

### Screen 1: Discover / Home Screen (`DiscoverScreen`)
- **Hero Promo Carousel**: High-impact editorial drop banner featuring Nike Air Max Dn8 with rich gradient overlay, "Just Dropped" pill badge, and "Shop Drop" call-to-action.
- **Interactive Category Selector**: Horizontal scrolling pill bar displaying categories (*All, Lifestyle, Running, Basketball, Training*) with active state elevation.
- **Trending Drops Row**: Horizontal sneaker showcase displaying product ratings, discounts, and high-resolution visuals.
- **Member Special Deal Card**: Promotional banner for 20% off with interactive "Use Code" trigger automatically activating promo code `NIKE20`.
- **New Releases Section**: Showcases fresh seasonal silhouettes.

### Screen 2: Catalog / Explore Screen (`CatalogScreen`)
- **Live Search Bar**: Prefix icon, clear action, and responsive debounced query filtering matching titles, tags, and categories.
- **Category Filter Bar**: Dynamic badge counter showing instant filtered count (`N Results`) and active sort indicators.
- **Responsive Product Grid**: Uses `LayoutBuilder` to compute columns dynamically:
  - Mobile (< 600px): 2 columns (aspect ratio 0.72)
  - Tablet (600px - 900px): 3 columns (aspect ratio 0.75)
  - Desktop (> 900px): 4-5 columns (aspect ratio 0.80)
- **Empty State**: Elegant fallback when queries yield no results, offering a single-tap reset action.

### Screen 3: Product Detail Screen (`ProductDetailScreen`)
- **Hero Image Gallery**: Fluid Hero transition from previous screen, back navigation button, and floating heart favorite toggle.
- **Information Header**: Category tag, bold headline, price, and star rating badge.
- **Interactive Color Swatches**: Real-time color selection with luminance-aware checkmark indicator.
- **Size Selector**: Size chips (*US 7 to US 12*) with interactive state handling and size guide action.
- **Technical Specs Accordion**: Details regarding delivery, authentication guarantee, and sustainable materials.
- **Sticky Cart Bar**: Bottom bar with live pricing and "Add to Bag" action, triggering animated snackbar feedback.
- **Dual-Pane Desktop Layout**: Automatically adapts to side-by-side layout on screens ≥ 750px width.

### Screen 4: Cart & Checkout Screen (`CartScreen`)
- **Cart Items List**: Each tile displays thumbnail, sneaker title, selected size, color indicator dot, unit total, and +/- quantity steppers with animated removal on zero quantity.
- **Promo Code Input Field**: Interactive uppercase validator with instant validation feedback.
- **Order Summary Card**: Itemized breakdown showing subtotal, applied promo savings, estimated shipping, tax, and bold grand total.
- **Quick Checkout Modal Sheet**: Simulates modern e-commerce checkout with delivery address selection, payment method selection, and instant confirmation dialog with generated order ID (`#NK-82914`).
- **Empty State**: Modern shopping bag graphic with a direct "Explore Drops" button navigating to the catalog.

### Screen 5: Profile & Settings Screen (`ProfileScreen`)
- **Profile Header Card**: Circular avatar, Nike Member Plus level badge, member email, and profile edit action.
- **Member Statistics Row**: Real-time counters showing Saved Items count, Items in Cart, and Nike Pass tokens.
- **Theme Mode Selector Card**: Dedicated 3-segment switcher allowing one-touch toggle between **Light**, **Dark**, and **System** themes.
- **Settings Group List**: Modern list tiles for Order History, Saved Addresses, Payment Methods, Notifications, and Customer Support.
- **Sign Out Action**: Branded button with feedback snackbar and app build version indicator.

---

## 3. Responsive Layout Strategy (`MediaQuery` & `LayoutBuilder`)

| Viewport Range | Cross-Axis Columns | Navigation Shell | Layout Structure |
|---|---|---|---|
| **Mobile (< 650px)** | 2 Columns | Bottom `NavigationBar` | Single-column vertical scroll |
| **Tablet (650px - 1024px)** | 3 Columns | Side `NavigationRail` | Adaptive multi-column grid |
| **Desktop (≥ 1024px)** | 4 to 5 Columns | Side `NavigationRail` | 2-column split (e.g. Product Detail) |

### Code Implementation Highlights:
```dart
// Dynamic Column Count & Aspect Ratio via LayoutBuilder
LayoutBuilder(
  builder: (context, constraints) {
    final columnCount = ResponsiveLayout.getGridColumnCount(constraints.maxWidth);
    final aspectRatio = ResponsiveLayout.getCardAspectRatio(constraints.maxWidth);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: aspectRatio,
      ),
      ...
    );
  },
)
```

---

## 4. Light & Dark Mode Architecture

The theme engine adheres to Material 3 design tokens:
- **Light Theme**: Pristine off-white background (`#F7F7F8`), pure white cards (`#FFFFFF`), dark graphite typography (`#111827`), and subtle outline borders (`#E5E7EB`).
- **Dark Theme**: Deep obsidian background (`#0F0F10`), charcoal elevated surfaces (`#18181B`), crisp white text (`#F9FAFB`), and high-energy Nike Volt accents (`#CEFF00`).
- **Theme Toggle**: Accessible via top AppBar button across all screens and via the dedicated Theme card in the Profile screen.

---

## 5. Verification & Compliance Checklist

| Requirement | Target | Achieved Status | Verification Method |
|---|---|---|---|
| Complete popular app clone | Nike E-Commerce (5+ screens) | **PASSED** (Discover, Catalog, Detail, Cart, Profile, Saved) | Code inspection & manual testing |
| Only Core Widgets | Zero external UI dependencies | **PASSED** (Material 3, InheritedNotifier, PageRouteBuilder) | `pubspec.yaml` audit |
| Build Method Line Count | < 50 lines per build method | **PASSED** (All 42 build methods ≤ 48 lines, 0 violations) | Automated AST PowerShell verification script |
| Responsive Layout | `MediaQuery` + `LayoutBuilder` | **PASSED** (Adaptive scaffold & dynamic grid system) | Tested on Mobile, Tablet & Desktop resolutions |
| Smooth Page Transitions | Custom routes & animations | **PASSED** (`AppPageRoute.slideRight` & `Hero` transitions) | Widget transitions testing |
| Dark & Light Mode Toggle | Dynamic theme switching | **PASSED** (Instant state-driven theme switching) | `ThemeController` & `MaterialApp.themeMode` |
| Flutter Analyze | 0 errors, 0 warnings | **PASSED** (No issues found) | `flutter analyze` exit code 0 |
| Flutter Test | All tests passing | **PASSED** (Smoke test & Cart calculations) | `flutter test` exit code 0 |

---

## 6. Demo Video Recording Guide (4-6 Minutes)

To record your MP4 demo:
1. **Introduction (0:00 - 0:45)**:
   - Launch app on Windows Desktop, Chrome, or Android Emulator.
   - Show the Discover (Home) screen: hero promo carousel, category chips, trending kicks, member deal.
2. **Catalog & Filtering (0:45 - 1:45)**:
   - Navigate to Catalog screen.
   - Type in search bar to filter kicks dynamically.
   - Switch category chips (*Running*, *Lifestyle*, *Basketball*).
3. **Product Detail & Hero Animation (1:45 - 2:45)**:
   - Tap any sneaker to show the smooth page slide and Hero image transition.
   - Toggle color swatches and shoe sizes.
   - Expand specifications accordion.
   - Tap "Add to Bag" to trigger cart counter badge update.
4. **Cart & Checkout Simulation (2:45 - 3:45)**:
   - Open Shopping Bag from bottom navigation or top cart badge.
   - Adjust quantities (+ / -), apply promo code `NIKE20` (demonstrating 20% discount calculation).
   - Tap "Proceed to Checkout", show delivery & payment options, tap "Place Order Now", and show confirmed dialog.
5. **Theme Switching & Profile (3:45 - 4:45)**:
   - Go to Profile screen.
   - Switch themes between Light and Dark mode using the profile switcher and the top AppBar toggle.
   - Show how surfaces, borders, and colors invert seamlessly.
6. **Responsiveness Demonstration (4:45 - 5:30)**:
   - Resize the window from compact mobile width to widescreen desktop/tablet width.
   - Highlight the transition from bottom `NavigationBar` to side `NavigationRail` and adaptive 2 to 4 column product grids.
