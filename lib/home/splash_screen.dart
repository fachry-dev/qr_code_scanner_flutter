import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo QR ScanGo
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo_splash_screen.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Teks ScanGo
            const Text(
              'ScanGo',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Color(0xFF43A078),
                letterSpacing: 1.2,
              ),
            ),
            const Text(
              'ticket scaner',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Colors.grey,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}