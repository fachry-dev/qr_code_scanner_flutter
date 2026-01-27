import 'package:flutter/material.dart';
// import 'package:qr_scanner/splash_screen.dart';
import 'package:qr_scanner/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScanGo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Outfit',
      ),
      
      initialRoute: '/splash',
      
      routes: {
        // '/splash': (context) => const SplashScreen(),
        '/home': (context) => HomeView(),
        // Tambahkan rute lain jika sudah ada pagenya
        // '/settings': (context) => const SettingView(),
      },
    );
  }
}