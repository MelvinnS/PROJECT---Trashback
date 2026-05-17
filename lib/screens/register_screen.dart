import 'package:flutter/material.dart';

import '../main.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String email) =>
      RegExp(r'^\S+@\S+\.\S+$').hasMatch(email);


  @override

  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }



  Future<void> _handleRegister() async {
    final form = _formKey.currentState;
      if (form == null) return;

    // Karena CustomTextField tidak mendukung validator bawaan,
    // validasi dilakukan manual.
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field wajib diisi'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Format email tidak valid'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password minimal 6 karakter'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan konfirmasi tidak sama'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }


    setState(() => _isLoading = true);
    try {
      final api = ApiService();

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      await api.register(email: email, password: password, name: name);

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registrasi Berhasil'),
          content: const Text('Registrasi berhasil, silakan login.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
    } catch (e) {
      if (!mounted) return;

      final msg = e.toString();
      final isConn = msg.contains('Tidak dapat terhubung ke server');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isConn
              ? 'Tidak dapat terhubung ke server, pastikan Mockoon berjalan'
              : msg),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Daftar Akun',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Lengkapi data diri untuk membuat\nakun TrashBack',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textGrey,
                          height: 1.5,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 28),

                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Nama Lengkap',
                        prefixAsset: 'assets/icons/ic_person.png',
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 14),

                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
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
                      const SizedBox(height: 14),

                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Konfirmasi Password',
                        prefixAsset: 'assets/icons/ic_password.png',
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppTheme.textGrey,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() =>
                                _obscureConfirmPassword = !_obscureConfirmPassword);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),


                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
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
                                  'Daftar Sekarang',
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

                      // Already have account
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Sudah Punya Akun? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textGrey,
                              fontFamily: 'Poppins',
                            ),
                            children: [
                              TextSpan(
                                text: 'Masuk Di sini',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

