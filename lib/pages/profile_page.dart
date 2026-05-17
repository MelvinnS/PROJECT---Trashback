import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/session_storage.dart';
import '../services/dummy_database.dart';

/// ProfilePage versi tugas:
/// 1) ambil token dari SharedPreferences
/// 2) panggil ApiService.getProfile(token)
/// 3) tampilkan name & address dari response (tanpa hardcode)
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService _api = ApiService();
  final DummyDatabase _db = DummyDatabase();

  bool _isLoading = true;
  Map<String, dynamic>? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);

    final token = await SessionStorage().getToken();
    if (token == null || token.isEmpty) {
      await SessionStorage().clear();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
      return;
    }

    try {
      final data = await _api.getProfile(token: token);
      if (!mounted) return;
      setState(() {
        _profile = data;
        _isLoading = false;
      });
    } catch (e) {
      final msg = e.toString();
      if (!mounted) return;

      if (msg.contains('401')) {
        await SessionStorage().clear();
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
        return;
      }

      // Jangan tampil dummy untuk name/address.
      setState(() {
        _profile = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = (_profile?['name'] ?? '') as String;
    final address = (_profile?['address'] ?? '') as String;

    final displayName = name.isNotEmpty ? name : 'Memuat...';
    final displayAddress = address.isNotEmpty ? address : 'Memuat...';

    final level = (_profile?['level'] ?? '') as String;
    final income = _db.stats['income'] as int;
    final totalDrop = _db.stats['totalDrop'] as int;
    final totalPickup = _db.stats['totalPickup'] as int;

    final incomeFormatted = _db.formatRupiah(income);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          const Spacer(),
                          const Icon(Icons.menu),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Jika ProfilePhoto kamu ingin dipakai, bisa di-include.
                    const SizedBox(height: 95),
                    const SizedBox(height: 14),

                    Text(
                      displayName,
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
                      displayAddress,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 30),

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
                          _buildStatCard(
                            icon: Icons.workspace_premium_outlined,
                            title: 'LEVEL',
                            value: level.isNotEmpty ? level : '—',
                            subtitle: 'Eco Rookie',
                          ),
                          _buildStatCard(
                            icon: Icons.account_balance_wallet_outlined,
                            title: 'PEMASUKAN',
                            value: incomeFormatted,
                          ),
                          _buildStatCard(
                            icon: Icons.shopping_basket_outlined,
                            title: 'TOTAL TARUH',
                            value: '$totalDrop kg',
                          ),
                          _buildStatCard(
                            icon: Icons.local_shipping_outlined,
                            title: 'TOTAL JEMPUT',
                            value: '$totalPickup kg',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

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
            color: const Color(0xFF2E7D32),
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

