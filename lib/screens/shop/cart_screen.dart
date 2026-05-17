// lib/screens/shop/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashback/screens/shop/checkout_screen.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _InsideCartScreenState();
}

class _InsideCartScreenState extends State<CartScreen> {
  static const Color _primaryGreen = Color(0xFF2E7D32);
  
  // State untuk melacak checkbox item yang dicentang berdasarkan ID Produk
  final Map<String, bool> _selectedItems = {};
  bool _isStoreSelected = true;

  String _formatPrice(double price) {
    final String s = price.toInt().toString();
    final buf = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buf.write('.');
      buf.write(s[i]);
      count++;
    }
    return 'Rp${buf.toString().split('').reversed.join()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Keranjang',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          // Ambil Map<String, CartItem> lalu jadikan List<CartItem>
          final cartList = cart.items.values.toList();

          if (cartList.isEmpty) {
            return const Center(
              child: Text(
                'Keranjang belanja kamu masih kosong nih.',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
              ),
            );
          }

          // Hitung total harga & item secara dinamis (Hanya yang dicentang)
          double totalHargaDihitung = 0;
          int totalItemDicentang = 0;

          for (var item in cartList) {
            // Daftarkan ID produk ke map checkbox jika belum ada
            _selectedItems.putIfAbsent(item.product.id, () => true);
            
            if (_selectedItems[item.product.id] == true) {
              totalHargaDihitung += (item.product.price * item.quantity);
              totalItemDicentang += item.quantity;
            }
          }

          return Column(
            children: [
              _buildAddressPanel(),
              
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Toko
                          _buildStoreHeader(cartList),
                          const Divider(height: 16, thickness: 0.5),
                          
                          // List Produk Berdasarkan Provider Kamu
                          ...cartList.map((item) {
                            return _buildCartItem(context, cart, item);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              _buildBottomActionBar(totalHargaDihitung, totalItemDicentang),
            ],
          );
        },
      ),
    );
  }

  // ─── Header Toko ───────────────────────────────────────────────────────────
  Widget _buildStoreHeader(List<dynamic> cartList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Checkbox(
            value: _isStoreSelected,
            activeColor: _primaryGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: (val) {
              setState(() {
                _isStoreSelected = val ?? false;
                for (var item in cartList) {
                  _selectedItems[item.product.id] = _isStoreSelected;
                }
              });
            },
          ),
          const Text(
            'Eco Future Store',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ─── Item Produk (Sudah disesuaikan dengan CartItem & Product) ──────────────
  Widget _buildCartItem(BuildContext context, CartProvider cart, dynamic item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: _selectedItems[item.product.id] ?? true,
            activeColor: _primaryGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: (val) {
              setState(() {
                _selectedItems[item.product.id] = val ?? false;
                _isStoreSelected = _selectedItems.values.every((element) => element == true);
              });
            },
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              // PENTING: Kalau di product_model variabelnya bukan 'imageUrl' tapi 'image', ganti teks di bawah ini
              item.product.imageUrl ?? 'https://picsum.photos/150',
              width: 76,
              height: 76,
              fit: BoxFit.cover,
              errorBuilder: (c, o, s) => Container(color: Colors.grey[300], width: 76, height: 76),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatPrice(item.product.price),
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    
                    // Tombol Tambah Kurang Kuantitas
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          _buildQtyBtn(Icons.remove, () {
                            if (item.quantity > 1) {
                              cart.updateQuantity(item.product.id, item.quantity - 1);
                            } else {
                              // Sesuai fungsi di provider lu: removeFromCart
                              cart.removeFromCart(item.product.id);
                            }
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                          _buildQtyBtn(Icons.add, () {
                            cart.updateQuantity(item.product.id, item.quantity + 1);
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(6),
        color: Colors.transparent,
        child: Icon(icon, size: 12, color: const Color(0xFF757575)),
      ),
    );
  }

  Widget _buildAddressPanel() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 6),
          const Expanded(
            child: Text(
              'Kirim ke: Rumah - Jl. Melati No.10, Jakarta',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(double totalHarga, int totalItem) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total ($totalItem produk)',
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Color(0xFF757575)),
                    ),
                    Text(
                      _formatPrice(totalHarga),
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: _primaryGreen),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                   onPressed: totalItem == 0 ? null : () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CheckoutScreen()),
  );
},
                    child: Text(
                      'Beli ($totalItem)',
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white),
                    ),
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