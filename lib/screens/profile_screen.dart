import 'package:flutter/material.dart';

import '../services/dummy_database.dart';
import '../widgets/profile_photo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DummyDatabase _db = DummyDatabase();

  static const Color primaryGreen = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    final name = _db.userProfile['name'] ?? '';
    final address = _db.userProfile['address'] ?? '';
    final level = _db.userProfile['level'] ?? '';

    final income = _db.stats['income'] as int;
    final totalDrop = _db.stats['totalDrop'] as int;
    final totalPickup = _db.stats['totalPickup'] as int;

    final incomeFormatted = _db.formatRupiah(income);

    return Scaffold(
      backgroundColor: Colors.white,

      // ✂️ HAPUS BLOK BOTTOMNAVBAR DI SINI BIAR GAK DOBEL SAMA INDUK UTAMA!

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // ====================================
              // HEADER
              // ====================================
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ✅ Back button simpel
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home',
                          (route) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: primaryGreen,
                        size: 22,
                      ),
                    ),

                    // ✅ Hamburger menu kanan
                    const Icon(
                      Icons.menu,
                      color: primaryGreen,
                      size: 28,
                    ),
                  ],
                ),
              ),

              // ====================================
              // PROFILE PHOTO
              // ====================================
              const SizedBox(height: 8),

              const Center(
                child: ProfilePhoto(
                  size: 95,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                address,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // ====================================
              // GRID STATISTIK 2x2
              // ====================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.1,
                  children: [
                    // LEVEL
                    _buildStatCard(
                      icon: Icons.workspace_premium_outlined,
                      title: 'LEVEL',
                      value: level,
                      subtitle: 'Eco Rookie',
                    ),

                    // PEMASUKAN
                    _buildStatCard(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'PEMASUKAN',
                      value: incomeFormatted,
                    ),

                    // TOTAL TARUH
                    _buildStatCard(
                      icon: Icons.shopping_basket_outlined,
                      title: 'TOTAL TARUH',
                      value: '$totalDrop kg',
                    ),

                    // TOTAL JEMPUT
                    _buildStatCard(
                      icon: Icons.local_shipping_outlined,
                      title: 'TOTAL JEMPUT',
                      value: '$totalPickup kg',
                    ),
                  ],
                ),
              ),

              // ====================================
              // ACHIEVEMENT HEADER
              // ====================================
              const SizedBox(height: 34),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Achivment',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ====================================
              // ACHIEVEMENT LIST
              // ====================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: _db.achievements.map((e) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 4,
                          ),
                          child: Row(
                            children: [
                              // Titik hijau kecil
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF43A047),
                                  shape: BoxShape.circle,
                                ),
                              ),

                              const SizedBox(width: 16),

                              // Judul achievement
                              Expanded(
                                child: Text(
                                  e['title'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              // Tanggal
                              Text(
                                e['date'] as String,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divider tipis
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFE0E0E0),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ====================================
  // CUSTOM STAT CARD
  // ====================================
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 30,
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}