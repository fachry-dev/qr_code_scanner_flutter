import 'package:flutter/material.dart';
// import 'package:qr_scanner/splash_screen.dart';
import 'package:qr_scanner/home/home_view.dart';
import 'package:qr_scanner/qr_code/qr_code_view.dart';
// import 'package:qr_scanner/settings/setting_view.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF43A078)),
        useMaterial3: true,
      ),      
      initialRoute: '/splash', 
      routes: {
        // '/splash': (context) => const SplashScreen(),
        '/home': (context) => HomeView(),
        '/qr_scan': (context) => QrCodeView(),
        // '/settings': (context) => const SettingView(),
      },
    );
  }
}