
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/dummy_database.dart';

class TaruhSampahScreen extends StatefulWidget {
  const TaruhSampahScreen({super.key});

  @override
  State<TaruhSampahScreen> createState() => _TaruhSampahScreenState();
}

class _TaruhSampahScreenState extends State<TaruhSampahScreen> {
  final DummyDatabase _db = DummyDatabase();

  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color bgColor = Color(0xFFF5F7FA);
  static const Color cancelRed = Color(0xFF7B2E2E);

  int _currentStep = 1;

  String? _selectedJenis;
  String? _selectedKondisi;

  final TextEditingController _beratController =
      TextEditingController(text: '3');

  final TextEditingController _catatanController =
      TextEditingController();

  final List<Map<String, dynamic>> jenisSampah = [
    {
      'name': 'Limbah Fashion',
      'price': 5000,
      'icon': Icons.checkroom,
    },
    {
      'name': 'Limbah Elektronik',
      'price': 12000,
      'icon': Icons.devices,
    },
    {
      'name': 'Limbah Konstruksi',
      'price': 3000,
      'icon': Icons.foundation,
    },
    {
      'name': 'Limbah Plastik',
      'price': 4500,
      'icon': Icons.recycling,
    },
    {
      'name': 'Limbah Kaca',
      'price': 2500,
      'icon': Icons.wine_bar,
    },
    {
      'name': 'Limbah Logam',
      'price': 8000,
      'icon': Icons.settings_suggest,
    },
  ];

  @override
  void initState() {
    super.initState();

    final data = _db.taruhSampahData;

    _selectedJenis = data['jenisSampah'] as String?;
    _selectedKondisi = data['kondisiSampah'] as String?;

    final berat =
        (data['estimasiBerat'] as num?)?.toDouble() ?? 3.0;

    _beratController.text = berat.toStringAsFixed(0);

    _catatanController.text =
        (data['catatan'] as String?) ?? '';
  }

  @override
  void dispose() {
    _beratController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  double get berat =>
      double.tryParse(_beratController.text) ?? 0;

  int get hargaPerKg {
    final item = jenisSampah.firstWhere(
      (e) => e['name'] == _selectedJenis,
      orElse: () => {'price': 0},
    );

    return item['price'] as int;
  }

  int get totalEcoCash => (berat * hargaPerKg).toInt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryGreen,
          ),
        ),
        title: const Text(
          'Taruh Sampah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            // ==========================
            // CUSTOM STEPPER
            // ==========================
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24),
              child: _buildStepper(),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Column(
                  children: [
                    if (_currentStep == 1) _buildStep1(),
                    if (_currentStep == 2) _buildStep2(),
                    if (_currentStep == 3) _buildStep3(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // STEPPER
  // =====================================================

  Widget _buildStepper() {
    Widget item(int number, String title) {
      final active = _currentStep >= number;

      return Expanded(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: number == 1
                        ? Colors.transparent
                        : active
                            ? primaryGreen
                            : Colors.grey.shade300,
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? primaryGreen
                        : Colors.grey.shade300,
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: number == 3
                        ? Colors.transparent
                        : _currentStep > number
                            ? primaryGreen
                            : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: active
                    ? primaryGreen
                    : Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        item(1, 'Data Sampah'),
        item(2, 'Verifikasi'),
        item(3, 'Konfirmasi'),
      ],
    );
  }

  // =====================================================
  // STEP 1
  // =====================================================

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Jenis Sampah'),
        const SizedBox(height: 14),

        SizedBox(
          height: 155,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: jenisSampah.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = jenisSampah[index];

              final selected =
                  _selectedJenis == item['name'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedJenis = item['name'];
                  });
                },
                child: Container(
                  width: 145,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(22),
                    border: Border.all(
                      color: selected
                          ? primaryGreen
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        item['icon'],
                        color: primaryGreen,
                        size: 34,
                      ),
                      const Spacer(),
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${_db.formatRupiah(item['price'])}/kg',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: primaryGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 28),

        _sectionTitle('Foto Sampah'),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: Container(
                height: 135,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(18),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/limbah.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Container(
                height: 135,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_a_photo_outlined,
                      color: primaryGreen,
                      size: 34,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tambah Foto',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        _sectionTitle('Estimasi Berat'),

        const SizedBox(height: 12),

        TextField(
          controller: _beratController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[0-9.]'),
            ),
          ],
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixText: 'kg',
            suffixStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'AI Memperkirakan 3-4kg',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 28),

        _sectionTitle('Kondisi Sampah'),

        const SizedBox(height: 14),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            'Bersih',
            'Kering',
            'Basah',
            'Campur',
          ].map((e) {
            final selected =
                _selectedKondisi == e;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedKondisi = e;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? primaryGreen
                      : Colors.white,
                  borderRadius:
                      BorderRadius.circular(30),
                ),
                child: Text(
                  e,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: selected
                        ? Colors.white
                        : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 28),

        _sectionTitle(
            'Catatan Tambahan (Opsional)'),

        const SizedBox(height: 12),

        TextField(
          controller: _catatanController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText:
                'Contoh: Sampah gua di kresek item mbud.',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 34),

        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: _continueStep1,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              'LANJUTKAN',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  // =====================================================
  // STEP 2
  // =====================================================

  Widget _buildStep2() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              _receiptRow(
                icon:
                    'assets/icons/ic_estimasi.png',
                title: 'Estimasi Berat',
                value: '${berat.toStringAsFixed(0)} kg',
              ),

              const SizedBox(height: 20),

              _receiptRow(
                icon: 'assets/icons/ic_kondisi.png',
                title: 'Kondisi Sampah',
                value:
                    _selectedKondisi ?? '-',
              ),

              const SizedBox(height: 20),

              _receiptRow(
                icon: 'assets/icons/ic_ecocash.png',
                title: 'Memperoleh EcoCash',
                value:
                    _db.formatRupiah(totalEcoCash),
                green: true,
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: const Text(
                  'Setelah request dibuat, petugas akan segera menuju lokasi anda untuk mengambil sampah.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: primaryGreen,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Lokasi Penjemputan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jl. Mawar No.12\nMalang, Jawa Timur',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/map_route.png',
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 34),

        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentStep = 3;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              'BUAT REQUEST',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  // =====================================================
  // STEP 3
  // =====================================================

  Widget _buildStep3() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Image.asset(
            'assets/images/verifikasi.png',
            width: 180,
          ),

          const SizedBox(height: 28),

          const Text(
            'Tunggu Petugas!',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Petugas sedang menuju lokasi anda.\nPastikan sampah sudah siap untuk diambil.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'SELESAI',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _showCancelDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: cancelRed,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'BATALKAN',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // HELPERS
  // =====================================================

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _receiptRow({
    required String icon,
    required String title,
    required String value,
    bool green = false,
  }) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 42,
          height: 42,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: green
                      ? primaryGreen
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // ACTIONS
  // =====================================================

  void _continueStep1() {
    if (_selectedJenis == null) {
      _showSnack(
          'Pilih jenis sampah terlebih dahulu');
      return;
    }

    if (berat <= 0) {
      _showSnack(
          'Estimasi berat harus lebih dari 0');
      return;
    }

    if (_selectedKondisi == null) {
      _showSnack(
          'Pilih kondisi sampah terlebih dahulu');
      return;
    }

    _db.saveTaruhSampahStep1({
      'jenisSampah': _selectedJenis,
      'fotoPath': null,
      'estimasiBerat': berat,
      'kondisiSampah': _selectedKondisi,
      'catatan': _catatanController.text.trim(),
    });

    setState(() {
      _currentStep = 2;
    });
  }

  void _showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),
          title: const Text(
            'Apakah anda yakin?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Request penjemputan akan dibatalkan.',
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Tidak',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cancelRed,
              ),
              child: const Text(
                'Ya, Batalkan',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

