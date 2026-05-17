// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../widgets/wallet_card.dart';
import '../widgets/feature_grid.dart';
import '../widgets/active_history_card.dart';
import '../widgets/recycle_items_carousel.dart';
import '../widgets/bottom_nav_bar.dart';
import 'shop/shop_screen.dart';
import 'profile_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: Stack(
        children: [
          // ── Konten Utama menggunakan IndexedStack (State halaman terjaga & bebas eror constructor) ──
          Positioned.fill(
            bottom: 65, // Memberikan ruang agar konten bawah tidak tertutup navbar
            child: IndexedStack(
              index: _currentNavIndex,
              children: [
                _buildHomeContent(),         // Index 0
                const HistoryScreen(),       // Index 1 (Hapus isEmbedded)
                const ShopScreen(),          // Index 2 (Hapus isEmbedded)
                const ProfileScreen(),       // Index 3 (Hapus isEmbedded)
              ],
            ),
          ),

          // ── Bottom Navigation Bar (Selalu menetap di bawah) ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              currentIndex: _currentNavIndex,
              onTap: (index) {
                setState(() => _currentNavIndex = index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─── Konten Tab 0: Beranda Utama ───────────────────────────────────────────
  Widget _buildHomeContent() {
    return Stack(
      children: [
        // Background header (Pattern & Avatar)
        Stack(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.15,
                child: Image.asset('assets/images/avatar.png', height: 150),
              ),
            ),
            Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
              ],
            ),
          ],
        ),

        // Scrollable content untuk data dashboard
        Positioned.fill(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: WalletCard(),
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Fitur dan Layanan', 'Lihat Semua »'),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: FeatureGrid(),
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Riwayat Taruh Aktif', null),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ActiveHistoryCard(),
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Barang Daur Ulang', 'Lihat Semua »'),
                const SizedBox(height: 12),
                const RecycleItemsCarousel(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Selamat Pagi,',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Earlene Zabrina',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700, // Fixed syntax weight
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          children: [
            SizedBox(width: 15),
            Icon(Icons.search, color: Colors.grey, size: 22),
            SizedBox(width: 10),
            Text(
              'Cari layanan...',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          if (action != null)
            Text(
              action,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}