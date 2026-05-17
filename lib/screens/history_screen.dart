import 'package:flutter/material.dart';
import '../services/dummy_database.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final DummyDatabase _db = DummyDatabase();
  static const Color primaryGreen = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    final transactions = _db.transactions;

    return Scaffold(
      backgroundColor: Colors.white,

      // ✂️ HAPUS BLOK BOTTOMNAVBAR DI SINI BIAR GAK DOBEL SAMA INDUKNYA!

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        // Tombol back dihapus jika ini halaman utama Tab, 
        // tapi kalau diakses dari halaman detail (checkout sukses) biarkan saja ada.
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryGreen,
            size: 22,
          ),
        ),
        title: const Text(
          'EcoCash',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // =========================
            // SALDO LINGKARAN
            // =========================
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryGreen,
                    width: 4,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Rp. 200.000',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF66BB6A),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // =========================
            // HEADER HISTORI
            // =========================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Histori',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // =========================
            // LIST TRANSAKSI
            // =========================
            Expanded(
              child: transactions.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada transaksi.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: transactions.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFE0E0E0),
                        );
                      },
                      itemBuilder: (context, index) {
                        final t = transactions[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
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
                              const SizedBox(width: 18),

                              // Nama barang
                              Expanded(
                                child: Text(
                                  (t['title'] ?? '') as String,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              // Tanggal
                              Text(
                                (t['date'] ?? '') as String,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}