// lib/providers/cart_provider.dart

import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

/// Model item di dalam keranjang
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  // Map<productId, CartItem> untuk lookup cepat
  final Map<String, CartItem> _items = {};

  // ─── Getters ──────────────────────────────────────────────

  /// Semua item di keranjang
  Map<String, CartItem> get items => Map.unmodifiable(_items);

  /// Total jumlah unit produk (untuk badge)
  int get totalItems {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Total harga keseluruhan
  double get totalPrice {
    return _items.values.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  /// Apakah keranjang kosong
  bool get isEmpty => _items.isEmpty;

  // ─── Actions ──────────────────────────────────────────────

  /// Tambah produk ke keranjang.
  /// Jika sudah ada, tambah quantity-nya.
  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  /// Kurangi quantity; hapus jika quantity menjadi 0
  void removeOneFromCart(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  /// Hapus produk sepenuhnya dari keranjang
  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  /// Kosongkan seluruh keranjang (misal: setelah checkout)
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Ubah quantity langsung ke angka tertentu
  void updateQuantity(String productId, int quantity) {
    if (!_items.containsKey(productId)) return;
    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      _items[productId]!.quantity = quantity;
    }
    notifyListeners();
  }

  /// Cek apakah produk sudah ada di keranjang
  bool isInCart(String productId) => _items.containsKey(productId);

  /// Ambil quantity produk tertentu (0 jika belum ada)
  int getQuantity(String productId) {
    return _items[productId]?.quantity ?? 0;
  }
}
