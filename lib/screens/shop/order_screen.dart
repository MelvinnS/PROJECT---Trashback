// lib/screens/shop/order_screen.dart

import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  // Menerima data kiriman dari halaman Checkout
  final List<dynamic>? checkoutItems;

  const OrderScreen({super.key, this.checkoutItems});

  static const Color _primaryGreen = Color(0xFF2E7D32);

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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Pesanan Saya',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF1A1A1A),
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: _primaryGreen,
            labelColor: _primaryGreen,
            unselectedLabelColor: Color(0xFF9E9E9E),
            labelStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 13),
            tabs: [
              Tab(text: 'Semua'),
              Tab(text: 'Belum Bayar'),
              Tab(text: 'Dikemas'),
              Tab(text: 'Dikirim'),
              Tab(text: 'Selesai'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(isAllTab: true), // Tab Semua
            const Center(child: Text('Belum ada pesanan Belum Bayar', style: TextStyle(fontFamily: 'Poppins'))),
            _buildOrderList(isAllTab: false, statusFilter: 'Dikemas'), // Tab Dikemas (FIXED: Sekarang nampilin data asli checkout)
            _buildOrderList(isAllTab: false, statusFilter: 'Dikirim'), // Tab Dikirim
            _buildOrderList(isAllTab: false, statusFilter: 'Selesai'), // Tab Selesai
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList({bool isAllTab = true, String statusFilter = ''}) {
    // 1. Buat list penampung data yang akan ditampilkan di UI
    List<Map<String, dynamic>> displayOrders = [];

    // 2. Jika ada data asli hasil checkout, masukkan data tersebut ke list teratas
    if (checkoutItems != null && checkoutItems!.isNotEmpty) {
      for (var item in checkoutItems!) {
        // Proteksi nama produk & harga
        String productName = 'Produk Ramah Lingkungan';
        double productPrice = 0.0;

        try {
          productName = item.product.name ?? productName;
          productPrice = (item.product.price ?? 0.0).toDouble();
        } catch (_) {}
        
        // PENTING: Cari cara ngambil gambar yang paling aman biar gak crash
        String productImage = 'https://picsum.photos/seed/eco/150/150';
        try {
          productImage = item.product.imageUrl ?? productImage;
        } catch (_) {
          try {
            productImage = item.product.image ?? productImage;
          } catch (__) {}
        }

        displayOrders.add({
          'store': 'Eco Future Store', 
          'status': 'Dikemas', 
          'product': productName,
          'qty': item.quantity ?? 1,
          'price': productPrice * (item.quantity ?? 1),
          'img': productImage,
        });
      }
    }

    // 3. Tambahkan data riwayat masa lalu (Dummy sesuai gambar Figma nomor 5)
    final historicalDummy = [
      {
        'store': 'Fall Store',
        'status': 'Selesai',
        'product': 'Organic T-Shirt Grey',
        'qty': 1,
        'price': 85000.0,
        'img': 'https://picsum.photos/seed/shirt1/150/150',
      },
      {
        'store': 'Green Home Store',
        'status': 'Dikirim',
        'product': 'Bamboo Straw Set',
        'qty': 2,
        'price': 24000.0,
        'img': 'https://picsum.photos/seed/straw/150/150',
      },
    ];
    displayOrders.addAll(historicalDummy);

    // 4. Logika Filter berdasarkan Tab yang sedang aktif
    if (!isAllTab) {
      displayOrders = displayOrders.where((order) => order['status'] == statusFilter).toList();
    }

    if (displayOrders.isEmpty) {
      return Center(
        child: Text(
          'Belum ada pesanan di kategori $statusFilter', 
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: displayOrders.length,
      itemBuilder: (context, index) {
        final order = displayOrders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    // Warnai teks status secara dinamis biar estetik sesuai mockup figma
    Color statusColor = _primaryGreen;
    if (order['status'] == 'Dikemas') statusColor = Colors.orange;
    if (order['status'] == 'Dikirim') statusColor = Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ]
      ),
      child: Column(
        children: [
          // Header Card: Nama Toko & Status Pesanan
          Row(
            children: [
              const Icon(Icons.storefront, size: 18, color: Color(0xFF616161)),
              const SizedBox(width: 8),
              Text(
                order['store'],
                style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const Spacer(),
              Text(
                order['status'],
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 11, color: statusColor),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 0.5),
          
          // Informasi Detail Produk
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  order['img'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (c, o, s) => Container(color: Colors.grey[300], width: 60, height: 60),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['product'],
                      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF1A1A1A)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order['qty']} barang',
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Total Biaya & Tombol Aksi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Pesanan',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Color(0xFF9E9E9E)),
                  ),
                  Text(
                    _formatPrice(order['price']),
                    style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1A1A1A)),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Text(
                    order['status'] == 'Selesai' ? 'Beli Lagi' : 'Lacak',
                    style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 11, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}