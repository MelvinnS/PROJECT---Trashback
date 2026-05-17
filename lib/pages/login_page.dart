import 'package:flutter/material.dart';

import '../main.dart';
import '../services/api_service.dart';
import '../services/session_storage.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_login_button.dart';

/// LoginPage versi tugas: pastikan user disimpan ke SharedPreferences
/// dengan key 'user' dalam bentuk JSON string.
/// (SessionStorage.saveUser sudah menyimpan dengan key `user` dan JSON string.)
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Validasi nyata sebelum request ke server.
    final emailValid = RegExp(r'^\S+@\S+\.\S+$').hasMatch(email);

    if (email.isEmpty || !emailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email wajib diisi dengan format yang benar'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password wajib diisi'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final api = ApiService();
      final result = await api.login(email: email, password: password);

      final token = result['token'] as String;
      final user = result['user'];

      // SessionStorage menyimpan:
      // - token ke key 'token'
      // - user ke key 'user' sebagai JSON string
      await SessionStorage().saveToken(token);
      await SessionStorage().saveUser(user);

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString();
      final isConn = msg.contains('Tidak dapat terhubung ke server');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isConn
                ? 'Tidak dapat terhubung ke server, pastikan Mockoon berjalan'
                : msg,
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBanner(size),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    const Text(
                      'Masuk Ke Akun',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Selamat Datang Kembali!',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textGrey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email atau nomor telepon',
                      prefixAsset: 'assets/icons/ic_email.png',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixAsset: 'assets/icons/ic_password.png',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppTheme.textGrey,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: AppTheme.borderGrey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Atau Masuk Dengan',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textGrey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(color: AppTheme.borderGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialLoginButton(
                          assetPath: 'assets/icons/ic_google.png',
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        SocialLoginButton(
                          assetPath: 'assets/icons/ic_apple.png',
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        SocialLoginButton(
                          assetPath: 'assets/icons/ic_phone.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Belum Punya Akun? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textGrey,
                              fontFamily: 'Poppins',
                            ),
                            children: [
                              TextSpan(
                                text: 'Daftar Sekarang',
                                style: TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppTheme.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildTopBanner(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_banner.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1B5E20),
                      Color(0xFF2E7D32),
                      Color(0xFF388E3C),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

