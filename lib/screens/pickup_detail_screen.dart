import 'package:flutter/material.dart';
import 'package:trashback/screens/pickup_succsess_screen.dart';

import 'chat_screen.dart';
import 'pickup_succsess_screen.dart';

class PickupDetailScreen extends StatelessWidget {
  const PickupDetailScreen({super.key});

  static const Color primaryGreen = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Jemput Sampah",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.05),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// PROFILE
              Row(
                children: [
                  const CircleAvatar(
  radius: 32,
  backgroundImage: AssetImage(
    'assets/images/Earlene.png',
  ),
),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Earlene Zabrina",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "Jl. Danau Towuti IV G5 D12\nKota Malang, Jawa Timur",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Informasi Kontak",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: primaryGreen,
                ),
              ),

              const SizedBox(height: 16),

              _contact(Icons.email_outlined, "zabrinaearlene@gmail.com"),
              _contact(Icons.call_outlined, "+62-896-507-44040"),
              _contact(Icons.facebook, "earlynn"),

              const Divider(height: 32),

              _rowItem("Jenis Sampah", "Limbah Fashion"),
              _rowItem("Estimasi Berat", "3 kg"),
              _rowItem("Kondisi Sampah", "Bersih"),

              const Divider(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Memperoleh EcoCash",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: primaryGreen,
                    ),
                  ),

                  Text(
                    "Rp. 15.000",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: primaryGreen,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Lokasi Penjemputan",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Jl. Danau Towuti IX G6 D14\nKota Malang, Jawa Timur",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                      ),
                    ),
                  ),

                 ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.asset(
    'assets/images/map_route.png',
    width: 100,
    height: 70,
    fit: BoxFit.cover,
  ),
),
                ],
              ),

              const Divider(height: 32),

              const Text(
                "Jadwal Penjemputan",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Hari ini, 14 Juni 2026\n14.00 - 16.00",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Catatan",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Tolong itu nya di anukan mbud",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [

            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChatScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryGreen),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Hubungi",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PickupSuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Jemput Sampah",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _contact(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }

  static Widget _rowItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}