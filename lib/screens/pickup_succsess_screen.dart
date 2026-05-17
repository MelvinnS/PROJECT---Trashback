import 'package:flutter/material.dart';

import 'chat_screen.dart';

class PickupSuccessScreen extends StatelessWidget {
  const PickupSuccessScreen({super.key});

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
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [

            const SizedBox(height: 40),

            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 80,
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "Jemput Sekarang!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Jika anda batalkan penjemputan sampah ini\nakan mengurangi level dan anda\nakan terkena pelanggaran.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                height: 1.6,
              ),
            ),

            const Spacer(),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Hubungi",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text(
                              "Apakah anda yakin?",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),

                            actions: [

                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false),

                                child: const Text(
                                  "Tidak",
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                              ),

                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.pop(context, true),

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade800,
                                ),

                                child: const Text(
                                  "Ya",
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (result == true && context.mounted) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D1B1B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Batalkan",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}