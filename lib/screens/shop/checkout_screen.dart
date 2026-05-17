// lib/screens/shop/checkout_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashback/screens/shop/order_screen.dart';
import '../../providers/cart_provider.dart';
import 'order_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color _primaryGreen = Color(0xFF2E7D32);

  // State Semi-Dinamis untuk simulasi pilihan User
  String _selectedCourier = 'Reguler';
  double _shippingFee = 10000; // Default Reguler
  String _selectedPayment = 'COD (Bayar di Tempat)';
  
  final double _voucherDiscount = 10000; // Potongan voucher sesuai mockup

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
          'Checkout',
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
          // Ambil item dari keranjang
          final cartList = cart.items.values.toList();
          
          // Hitung total harga barang dasar
          double totalHargaProduk = 0;
          for (var item in cartList) {
            totalHargaProduk += (item.product.price * item.quantity);
          }

          // Hitung total akhir (Produk + Ongkir - Voucher) -> FIX: Spasi dihapus
          double totalPembayaranAkhir = totalHargaProduk + _shippingFee - _voucherDiscount;
          if (totalPembayaranAkhir < 0) totalPembayaranAkhir = 0;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // 1. Alamat Pengiriman
                    _buildAddressSection(),
                    const SizedBox(height: 8),

                    // 2. Ringkasan Produk (Menampilkan apa yang ada di keranjang)
                    _buildOrderSummarySection(cartList),
                    const SizedBox(height: 8),

                    // 3. Metode Pengiriman (Interaktif)
                    _buildShippingSection(),
                    const SizedBox(height: 8),

                    // 4. Rincian Tagihan
                    _buildBillingDetailSection(totalHargaProduk, totalPembayaranAkhir),
                    const SizedBox(height: 8),

                    // 5. Metode Pembayaran (Interaktif)
                    _buildPaymentMethodSection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Bottom Bar: Tombol Buat Pesanan
              _buildBottomButton(cart, totalPembayaranAkhir),
            ],
          );
        },
      ),
    );
  }

  // ─── 1. WIDGET ALAMAT PENGIRIMAN ──────────────────────────────────────────
  Widget _buildAddressSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alamat Pengiriman',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Simulasi: Alamat sudah diatur utama')),
                  );
                },
                child: const Text(
                  'Ubah',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 12, color: _primaryGreen),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, color: _primaryGreen, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rumah (Aldi Muhammad)',
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '6281234567890\nJl. Melati No.10, RT 03 / RW 02\nKec. Pancoran, Kota Jakarta Selatan\nDKI Jakarta, 12780',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Color(0xFF616161), height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ─── 2. WIDGET RINGKASAN PRODUK ────────────────────────────────────────────
  Widget _buildOrderSummarySection(List<dynamic> cartList) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Eco Future Store',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const Divider(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = cartList[index];
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      item.product.imageUrl ?? 'https://picsum.photos/150',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (c, o, s) => Container(color: Colors.grey[300], width: 50, height: 50),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.quantity}x  |  ${_formatPrice(item.product.price)}',
                          style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Color(0xFF757575)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── 3. WIDGET METODE PENGIRIMAN (INTERAKTIF) ──────────────────────────────
  Widget _buildShippingSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metode Pengiriman',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedCourier,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: _primaryGreen)),
            ),
            items: const [
              DropdownMenuItem(value: 'Reguler', child: Text('Reguler (Estimasi 2-4 Hari) - Rp10.000', style: TextStyle(fontFamily: 'Poppins', fontSize: 12))),
              DropdownMenuItem(value: 'Hemat', child: Text('Hemat (Estimasi 4-7 Hari) - Rp5.000', style: TextStyle(fontFamily: 'Poppins', fontSize: 12))),
              DropdownMenuItem(value: 'Kargo', child: Text('Kargo (Barang Besar) - Rp25.000', style: TextStyle(fontFamily: 'Poppins', fontSize: 12))),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCourier = value!;
                if (_selectedCourier == 'Reguler') _shippingFee = 10000;
                if (_selectedCourier == 'Hemat') _shippingFee = 5000;
                if (_selectedCourier == 'Kargo') _shippingFee = 25000;
              });
            },
          ),
        ],
      ),
    );
  }

  // ─── 4. WIDGET RINGKASAN TAGIHAN ───────────────────────────────────────────
  Widget _buildBillingDetailSection(double totalProduk, double totalAkhir) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Pesanan',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 12),
          _buildBillingRow('Total Produk', _formatPrice(totalProduk)),
          _buildBillingRow('Total Ongkir', _formatPrice(_shippingFee)),
          _buildBillingRow('Voucher Diskon', '- ${_formatPrice(_voucherDiscount)}', isDiscount: true),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Pembayaran', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13)),
              Text(_formatPrice(totalAkhir), style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 14, color: _primaryGreen)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingRow(String title, String val, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Color(0xFF757575))),
          Text(val, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: isDiscount ? _primaryGreen : Colors.black)),
        ],
      ),
    );
  }

  // ─── 5. WIDGET METODE PEMBAYARAN (INTERAKTIF) ──────────────────────────────
  Widget _buildPaymentMethodSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metode Pembayaran',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedPayment,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: _primaryGreen)),
            ),
            items: const [
              DropdownMenuItem(value: 'COD (Bayar di Tempat)', child: Text('COD (Bayar di Tempat)', style: TextStyle(fontFamily: 'Poppins', fontSize: 12))),
              DropdownMenuItem(value: 'Transfer Bank VA', child: Text('Transfer Bank Virtual Account', style: TextStyle(fontFamily: 'Poppins', fontSize: 12))),
              DropdownMenuItem(value: 'Gopay / ShopeePay', child: Text('E-Wallet (Gopay / ShopeePay)', style: TextStyle(fontFamily: 'Poppins', fontSize: 12))),
            ],
            onChanged: (value) {
              setState(() {
                _selectedPayment = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  // ─── BOTTOM BAR & TRIGGER LOGIC (BUAT PESANAN) ─────────────────────────────
  Widget _buildBottomButton(CartProvider cart, double totalAkhir) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Total Pembayaran', style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Color(0xFF757575))),
              Text(_formatPrice(totalAkhir), style: const TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: _primaryGreen)),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 150,
            height: 42,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
             onPressed: () {
  // 1. Ambil data barang yang ada di keranjang saat ini sebelum di-clear
  final purchasedItems = cart.items.values.toList();

  // 2. Bersihkan keranjang belanja
  cart.clearCart();

  // 3. Munculkan status sukses di layar
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(backgroundColor: Color(0xFF2E7D32), content: Text('Pesanan Berhasil Dibuat!')),
  );

  // 4. Pindah ke Halaman Pesanan dengan membawa data asli tadi
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => OrderScreen(checkoutItems: purchasedItems),
    ),
  );
},
              child: const Text(
                'Buat Pesanan',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}