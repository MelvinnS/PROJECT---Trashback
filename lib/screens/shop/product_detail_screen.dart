// lib/screens/shop/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart'; // Sesuaikan dengan path provider keranjang lu

class ProductDetailScreen extends StatefulWidget {
  // Menerima object data produk dinamis dari halaman utama (Home/Shop)
  final dynamic product; 

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  static const Color _primaryGreen = Color(0xFF2E7D32);
  bool _isFavorite = false;
  int _selectedVariantIndex = 0;

  // Format Rupiah (ex: Rp35.000)
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
    // FIX: Deteksi apakah data berupa Map atau Object Model biar gak NoSuchMethodError
    String name = 'Pot Tanaman Minimalis';
    double price = 35000.0;
    String imgUrl = 'https://picsum.photos/seed/pot/400/400';
    String description = 'Pot tanaman dengan desain minimalis modern. Terbuat dari semen daur ulang, cocok untuk menghias meja kerja atau sudut ruangan Anda agar terlihat lebih asri dan ramah lingkungan.';

    if (widget.product != null) {
      try {
        // Coba baca pakai gaya Object (.name) sesuai error lu
        name = widget.product.name ?? name;
        price = (widget.product.price ?? price).toDouble();
        imgUrl = widget.product.imageUrl ?? imgUrl;
        description = widget.product.description ?? description;
      } catch (_) {
        try {
          // Fallback kalau ternyata di halaman lain dikirim pakai gaya Map (['name'])
          name = widget.product['name'] ?? name;
          price = (widget.product['price'] ?? price).toDouble();
          imgUrl = widget.product['imageUrl'] ?? imgUrl;
          description = widget.product['description'] ?? description;
        } catch (_) {}
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ─── KONTEN UTAMA SCROLLABLE ─────────────────────────────────────────
          SelectionArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar Utama Produk
                  Image.network(
                    imgUrl,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 1.05,
                    fit: BoxFit.cover,
                    errorBuilder: (c, o, s) => Container(
                      color: Colors.grey[200],
                      width: double.infinity,
                      height: 380,
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  ),
                  
                  // Detail Informasi Produk
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatPrice(price),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            const Text(
                              '4.6',
                              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Text(
                              '  |  Terjual 521',
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  Container(height: 8, color: const Color(0xFFF5F5F5)),
                  
                  // Seksi Garansi & Ongkir
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          Icons.verified_user_outlined, 
                          'Garansi tiba: 2 - 4 Jun', 
                          'Dapatkan voucher jika pesanan terlambat.'
                        ),
                        const Divider(height: 1, thickness: 0.5),
                        _buildInfoTile(
                          Icons.local_shipping_outlined, 
                          'Gratis ongkir', 
                          'Untuk pesanan Rp30.000+'
                        ),
                      ],
                    ),
                  ),

                  Container(height: 8, color: const Color(0xFFF5F5F5)),
                  
                  // Seksi Pilihan Variasi
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pilih Variasi',
                              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Row(
                              children: [
                                Text(
                                  '3 pilihan',
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey[400]),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(3, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedVariantIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _selectedVariantIndex == index ? _primaryGreen : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, o, s) => const Icon(Icons.image, size: 20, color: Colors.grey),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  Container(height: 8, color: const Color(0xFFF5F5F5)),
                  
                  // Seksi Deskripsi Produk
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deskripsi Produk',
                          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xFF4A4A4A),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // ─── TOMBOL TOP BAR MELAYANG (BACK, SHARE, FAVORITE) ─────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A), size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        radius: 18,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.share_outlined, color: Color(0xFF1A1A1A), size: 20),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        radius: 18,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border, 
                            color: _isFavorite ? Colors.red : const Color(0xFF1A1A1A),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      
      // ─── BOTTOM NAVIGATION BAR ─────────────────────────────────────────────
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), 
              blurRadius: 8, 
              offset: const Offset(0, -3)
            )
          ]
        ),
        child: Row(
          children: [
            _buildBottomIconAction(Icons.storefront, 'Toko'),
            _buildBottomIconAction(Icons.chat_bubble_outline, 'Chat'),
            const SizedBox(width: 8),
            
            // Tombol Tambah ke Keranjang Belanja
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 42,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: _primaryGreen, width: 1.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    try {
                      final cart = Provider.of<CartProvider>(context, listen: false);
                      cart.addToCart(widget.product); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: _primaryGreen,
                          content: Text('Dimasukkan ke keranjang!', style: TextStyle(fontFamily: 'Poppins')),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } catch (_) {}
                  },
                  child: const Text(
                    'Tambah ke\nKeranjang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins', 
                      fontWeight: FontWeight.bold, 
                      fontSize: 11, 
                      color: _primaryGreen, 
                      height: 1.2
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            
            // TOMBOL "BELI SEKARANG" -> AMAN DARI ERROR INSTANCE OF PRODUCT
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Meneruskan object product asli langsung tanpa diubah jadi Map ilegal
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RealCheckoutScreen(
                          directProduct: widget.product, 
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Beli Sekarang',
                    style: TextStyle(
                      fontFamily: 'Poppins', 
                      fontWeight: FontWeight.bold, 
                      fontSize: 12, 
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomIconAction(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: const Color(0xFF555555)),
            const SizedBox(height: 2),
            Text(
              label, 
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 10, color: Color(0xFF555555))
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: _primaryGreen, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF1A1A1A))
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle, 
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Color(0xFF888888))
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ],
      ),
    );
  }
}


// ===============================================================================
// HALAMAN FORM CHECKOUT (FIXED: BISA BACA KEDUA JENIS DATA OBJECT ATAUPUN MAP)
// ===============================================================================
class RealCheckoutScreen extends StatefulWidget {
  final dynamic directProduct;

  const RealCheckoutScreen({super.key, this.directProduct});

  @override
  State<RealCheckoutScreen> createState() => _RealCheckoutScreenState();
}

class _RealCheckoutScreenState extends State<RealCheckoutScreen> {
  static const Color _themeGreen = Color(0xFF2E7D32);
  String _selectedShipping = 'Reguler (Estimasi 2-4 Hari) - Rp10.000';
  String _selectedPayment = 'COD (Bayar di Tempat)';

  String _formatCurrency(double value) {
    final String s = value.toInt().toString();
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
    // Fallback data default
    String pName = 'Pot Tanaman Minimalis';
    double pPrice = 35000.0;
    String pImg = 'https://picsum.photos/seed/pot/400/400';

    // Pengaman ekstra pembacaan model data produk biar ga crash lagi
    if (widget.directProduct != null) {
      try {
        pName = widget.directProduct.name ?? pName;
        pPrice = (widget.directProduct.price ?? pPrice).toDouble();
        pImg = widget.directProduct.imageUrl ?? pImg;
      } catch (_) {
        try {
          pName = widget.directProduct['name'] ?? pName;
          pPrice = (widget.directProduct['price'] ?? pPrice).toDouble();
          pImg = widget.directProduct['imageUrl'] ?? pImg;
        } catch (_) {}
      }
    }

    double shippingCost = 10000.0;
    double discount = 10000.0;
    double totalPayment = pPrice + shippingCost - discount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Seksi Alamat Pengiriman
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Alamat Pengiriman', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 14)),
                      Text('Ubah', style: TextStyle(fontFamily: 'Poppins', color: _themeGreen, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: _themeGreen, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Rumah (Aldi Muhammad)', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13)),
                            const SizedBox(height: 2),
                            Text(
                              '6281234567890\nJl. Melati No.10, RT 03 / RW 02\nKec. Pancoran, Kota Jakarta Selatan\nDKI Jakarta, 12780',
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey[600], height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // 2. Seksi Identitas Toko & Barang yang Dibeli
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Eco Future Store', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 12),
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(pImg, width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pName, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text('1x  |  ${_formatCurrency(pPrice)}', style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey[500])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // 3. Seksi Pilihan Dropdown Metode Pengiriman
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Metode Pengiriman', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedShipping,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: ['Reguler (Estimasi 2-4 Hari) - Rp10.000']
                            .map((e) => DropdownMenuItem(child: Text(e, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)), value: e))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedShipping = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // 4. Seksi Ringkasan Rincian Pembayaran
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ringkasan Pesanan', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Total Produk', _formatCurrency(pPrice)),
                  _buildSummaryRow('Total Ongkir', _formatCurrency(shippingCost)),
                  _buildSummaryRow('Voucher Diskon', '- ${_formatCurrency(discount)}', isDiscount: true),
                  const SizedBox(height: 6),
                  const Divider(thickness: 0.5),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Pembayaran', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(_formatCurrency(totalPayment), style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 14, color: _themeGreen)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // 5. Seksi Pilihan Dropdown Metode Pembayaran
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Metode Pembayaran', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPayment,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: ['COD (Bayar di Tempat)']
                            .map((e) => DropdownMenuItem(child: Text(e, style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)), value: e))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedPayment = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // Spacer bawah
          ],
        ),
      ),
      
      // ─── BOTTOM NAVBAR CHECKOUT: TOTAL & BUTTON BUAT PESANAN ──────────────────
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, -2))]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Pembayaran', style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(_formatCurrency(totalPayment), style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16, color: _themeGreen)),
              ],
            ),
            SizedBox(
              height: 40,
              width: 160,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _themeGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                onPressed: () {
                  // Aksi tombol "Buat Pesanan" ke status order / pesanan
                },
                child: const Text('Buat Pesanan', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey)),
          Text(value, style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: isDiscount ? _themeGreen : Colors.black)),
        ],
      ),
    );
  }
}