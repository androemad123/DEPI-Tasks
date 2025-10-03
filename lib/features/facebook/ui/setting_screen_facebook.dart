import 'package:flutter/material.dart';

import '../../sign up -in/auth/auth_service.dart';
import '../../sign up -in/login_screen.dart';

class SettingScreenFacebook extends StatefulWidget {
  const SettingScreenFacebook({super.key});

  @override
  State<SettingScreenFacebook> createState() => _SettingScreenFacebookState();
}

class _SettingScreenFacebookState extends State<SettingScreenFacebook> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF6A85B6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
          elevation: 5,
        ),
        onPressed: () async {
          await AuthService.logout();
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        },
        child: const Text(
          "logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
