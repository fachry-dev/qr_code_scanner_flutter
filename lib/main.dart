import 'package:flutter/material.dart';
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
      title: 'ScanGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF43A078),
          primary: const Color(0xFF43A078),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF1F8E9), 
      ),
      
  
      initialRoute: '/',
      
      routes: {
        '/': (context) => HomeView(),
        '/qr_scan': (context) => QrCodeView(),
        // '/settings': (context) => const SettingView(),
      },
    );
  }
}