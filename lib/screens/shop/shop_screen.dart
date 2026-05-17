// lib/screens/shop/shop_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../data/dummy_products.dart';
import '../../widgets/cart_badge_icon.dart';
import 'product_detail_screen.dart';

class ShopScreen extends StatefulWidget {
  /// isEmbedded: true = dipakai sebagai tab dalam HomeScreen (tanpa Scaffold)
  final bool isEmbedded;

  const ShopScreen({super.key, this.isEmbedded = false});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController _searchController = TextEditingController();
  static const Color _primaryGreen = Color(0xFF2E7D32);

  // Foto toko dari Picsum dengan seed stabil (selalu gambar yang sama)
  static const List<Map<String, String>> _storeData = [
    {
      'name': 'Budi Speed',
      'subtitle': '291.100 Pengikut',
      'image': 'https://picsum.photos/seed/store1/150/150',
    },
    {
      'name': 'Fall Store',
      'subtitle': '241.260 Pengikut',
      'image': 'https://picsum.photos/seed/store2/150/150',
    },
    {
      'name': 'Zabrina Dress',
      'subtitle': '53.908 Pengikut',
      'image': 'https://picsum.photos/seed/store3/150/150',
    },
    {
      'name': 'Tirza Store',
      'subtitle': '59.298 Pengikut',
      'image': 'https://picsum.photos/seed/store4/150/150',
    },
    {
      'name': 'Eco Fresh',
      'subtitle': '12.400 Pengikut',
      'image': 'https://picsum.photos/seed/store5/150/150',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    final content = SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isEmbedded
              ? SafeArea(bottom: false, child: _buildAppBar())
              : _buildAppBar(),
          _buildSearchBar(),
          _buildBanner(),
          _buildQuickCategories(),
          _buildFlashSaleSection(),
          _buildExclusiveStores(),
          _buildSectionHeader('Pilihan Untukmu'),
          _buildProductGrid(),
          const SizedBox(height: 24),
        ],
      ),
    );

    if (widget.isEmbedded) return content;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(child: content),
    );
  }

  // ─── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Row(
        children: [
          const Text(
            'TrashBack Shop',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: _primaryGreen,
            ),
          ),
          const Spacer(),
          _iconBtn(Icons.notifications_outlined, () {}),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CartBadgeIcon(
              onTap: () => Navigator.pushNamed(context, '/cart'),
            ),
          ),
          const SizedBox(width: 4),
          _iconBtn(Icons.chat_bubble_outline, () {}),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 22, color: const Color(0xFF1A1A1A)),
        ),
      );

  // ─── Search Bar ───────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
        decoration: InputDecoration(
          hintText: 'Cari produk atau toko',
          hintStyle: const TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: Color(0xFFBDBDBD)),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _primaryGreen, width: 1)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          isDense: true,
        ),
      ),
    );
  }

  // ─── Banner ───────────────────────────────────────────────────────────────
  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _primaryGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Teks — Flexible agar tidak overflow ke kanan
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '🌿 Promo Spesial Untuk Kamu',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Belanja Hemat,\nBumi Selamat',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Diskon Hingga 50%',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Belanja Sekarang',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _primaryGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 70,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text('🛍️', style: TextStyle(fontSize: 36))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Kategori Cepat ───────────────────────────────────────────────────────
  Widget _buildQuickCategories() {
    final cats = [
      {'icon': Icons.local_shipping_outlined, 'label': 'Gratis Ongkir'},
      {'icon': Icons.flash_on_outlined, 'label': 'Flash Sale'},
      {'icon': Icons.confirmation_number_outlined, 'label': 'Voucher'},
      {'icon': Icons.grid_view_outlined, 'label': 'Kategori'},
    ];
    return Container(
      margin: const EdgeInsets.only(top: 12),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: cats
            .map((c) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(c['icon'] as IconData,
                          color: _primaryGreen, size: 22),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['label'] as String,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF424242),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }

  // ─── Flash Sale ───────────────────────────────────────────────────────────
  Widget _buildFlashSaleSection() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Icon(Icons.flash_on, color: Colors.orange[700], size: 20),
                const SizedBox(width: 4),
                const Text(
                  'Flash Sale',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(width: 8),
                _timerChip('02'),
                _timerSep(),
                _timerChip('14'),
                _timerSep(),
                _timerChip('38'),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Lihat Semua >',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: _primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tinggi cukup untuk kartu + padding bawah
          SizedBox(
            height: 225,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              itemCount: flashSaleProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) => _buildFlashSaleCard(flashSaleProducts[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timerChip(String v) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(v,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )),
      );

  Widget _timerSep() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Text(':',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
      );

  Widget _buildFlashSaleCard(Product product) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        ),
      );
    },
    child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        // Column + mainAxisSize.min agar tinggi organik, tidak overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12)),
                  child: Image.network(
                    product.imageUrl,
                    height: 108,
                    width: 130,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 108,
                      width: 130,
                      color: const Color(0xFFE8F5E9),
                      child:
                          Icon(Icons.image_outlined, color: Colors.grey[400]),
                    ),
                  ),
                ),
                if (product.discountPercent != null)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product.discountPercent}%',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatPrice(product.price),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _primaryGreen,
                    ),
                  ),
                  if (product.discountPercent != null)
                    Text(
                      _formatPrice(product.originalPrice),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0xFFBDBDBD),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const SizedBox(height: 3),
                  // ← maxLines: 2 + ellipsis, tidak overflow
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF424242),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Color(0xFFFFEBEE),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red),
                      minHeight: 4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Tersisa sedikit',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Toko Eksklusif ───────────────────────────────────────────────────────
  Widget _buildExclusiveStores() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                const Text(
                  'Toko Eksklusif',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Lihat Semua >',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: _primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              itemCount: _storeData.length,
              separatorBuilder: (_, __) => const SizedBox(width: 18),
              itemBuilder: (_, i) {
                final store = _storeData[i];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ← CircleAvatar dengan NetworkImage dari Picsum
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFFE8F5E9),
                      backgroundImage: NetworkImage(store['image']!),
                      onBackgroundImageError: (_, __) {},
                    ),
                    const SizedBox(height: 5),
                    Text(
                      store['name']!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      store['subtitle']!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section Header ───────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Lihat Semua >',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: _primaryGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Product Grid ─────────────────────────────────────────────────────────
  // Wrap menggantikan GridView agar tidak ada nested scroll konflik
  Widget _buildProductGrid() {
    final double screenW = MediaQuery.of(context).size.width;
    final double cardW = (screenW - 16 * 2 - 10) / 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: recommendedProducts
            .map((p) => SizedBox(width: cardW, child: _buildProductCard(p)))
            .toList(),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(product: product),
        ),
      );
    },
    child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12)),
                  child: Image.network(
                    product.imageUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 130,
                      color: const Color(0xFFE8F5E9),
                      child: Icon(Icons.image_outlined,
                          color: Colors.grey[400], size: 36),
                    ),
                  ),
                ),
                if (product.discountPercent != null)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product.discountPercent}%',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.favorite_border,
                        size: 14, color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatPrice(product.price),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _primaryGreen,
                    ),
                  ),
                  if (product.discountPercent != null)
                    Text(
                      _formatPrice(product.originalPrice),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Color(0xFFBDBDBD),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 11, color: Colors.orange[600]),
                      const SizedBox(width: 2),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: Color(0xFF757575),
                        ),
                      ),
                      if (product.isFreeShipping) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text(
                            'Gratis Ongkir',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 8,
                              color: _primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.storeInfo.storeName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9,
                      color: Color(0xFFBDBDBD),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  _buildAddToCartButton(product),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(Product product) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final bool inCart = cart.isInCart(product.id);
        return GestureDetector(
          onTap: () {
            cart.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${product.name} ditambahkan ke keranjang',
                  style:
                      const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: _primaryGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              color: inCart ? const Color(0xFFE8F5E9) : _primaryGreen,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _primaryGreen),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  inCart ? Icons.shopping_bag : Icons.add_shopping_cart,
                  size: 13,
                  color: inCart ? _primaryGreen : Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  inCart ? 'Di Keranjang' : '+ Keranjang',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: inCart ? _primaryGreen : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
