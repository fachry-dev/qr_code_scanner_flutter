import 'package:flutter/material.dart';
import 'package:qr_scanner/home/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = HomeController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ScanGo',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF43A078),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pushNamed(context, '/settings'),
                      icon: const Icon(Icons.settings_outlined, color: Color(0xFF43A078), size: 28),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Hai User 👋',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 16, 
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildMenuCard(
                          title: 'Generate QR',
                          subtitle: 'Create QR fast',
                          icon: Icons.qr_code_2,
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _buildMenuCard(
                          title: 'Scan Qr',
                          subtitle: 'Scan any ticket',
                          icon: Icons.qr_code_scanner,
                          onTap: () => controller.goToQRCodeView(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildMenuCard(
                          title: 'Send',
                          subtitle: 'Send to mail',
                          icon: Icons.mail_outline,
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _buildMenuCard(
                          title: 'Print',
                          subtitle: 'Print ticket',
                          icon: Icons.print_outlined,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke Riwayat/History
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF43A078),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'History',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        '2026©ScanGo.All right reserved',
                        style: TextStyle(fontFamily: 'Outfit', color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        'Terms and Conditions',
                        style: TextStyle(fontFamily: 'Outfit', color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: const Color(0xFF43A078),
                child: Icon(icon, color: Colors.white, size: 35),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}