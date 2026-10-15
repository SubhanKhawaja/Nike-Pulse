import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];
  String? _appliedPromoCode;
  double _promoDiscountPercent = 0.0;

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  String? get appliedPromoCode => _appliedPromoCode;
  double get promoDiscountPercent => _promoDiscountPercent;

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get discountAmount => subtotal * _promoDiscountPercent;

  double get shippingFee {
    if (_items.isEmpty) return 0.0;
    return subtotal > 150.0 ? 0.0 : 15.0; // Free shipping over $150
  }

  double get estimatedTax => (subtotal - discountAmount) * 0.08;

  double get grandTotal {
    if (_items.isEmpty) return 0.0;
    return (subtotal - discountAmount) + shippingFee + estimatedTax;
  }

  void addToCart(Product product, String size, Color color, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          selectedSize: size,
          selectedColor: color,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(item);
    } else {
      final index = _items.indexWhere((i) => i.uniqueKey == item.uniqueKey);
      if (index >= 0) {
        _items[index].quantity = newQuantity;
      } else {
        item.quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    _items.removeWhere((i) => i.uniqueKey == item.uniqueKey);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _appliedPromoCode = null;
    _promoDiscountPercent = 0.0;
    notifyListeners();
  }

  bool applyPromoCode(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'NIKE20' || cleanCode == 'JUSTDOIT') {
      _appliedPromoCode = cleanCode;
      _promoDiscountPercent = 0.20; // 20% discount
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromoCode() {
    _appliedPromoCode = null;
    _promoDiscountPercent = 0.0;
    notifyListeners();
  }
}
