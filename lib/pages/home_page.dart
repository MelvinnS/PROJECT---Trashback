import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/session_storage.dart';

/// HomePage versi tugas: ambil user dari SharedPreferences key `user`.
/// Lalu tampilkan nama di sapaan (tanpa hardcode).
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    setState(() => _loading = true);

    final userRaw = await SessionStorage().getUserRaw();
    if (userRaw == null || userRaw.isEmpty) {
      if (!mounted) return;
      await SessionStorage().clear();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
      return;
    }

    try {
      final decoded = jsonDecode(userRaw);
      final name = decoded['name'];

      if (!mounted) return;
      setState(() {
        _userName = name is String ? name : '';
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      await SessionStorage().clear();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _userName.isNotEmpty ? _userName : 'Memuat...';

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: SafeArea(
        child: Center(
          child: _loading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Selamat Pagi,',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        displayName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

