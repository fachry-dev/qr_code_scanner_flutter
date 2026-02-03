import 'package:flutter/material.dart';
import 'package:qr_scanner/home/home_controller.dart';
import 'package:qr_scanner/features/history/models/ticket_model.dart';
import 'package:qr_scanner/features/history/widgets/history_card.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = HomeController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      body: Stack(
        children: [
          SafeArea(
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
                          onPressed: () =>
                              Navigator.pushNamed(context, '/settings'),
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Color(0xFF43A078),
                            size: 28,
                          ),
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      _buildMenuCard(
                        title: 'Generate QR',
                        subtitle: 'Create QR fast',
                        icon: Icons.qr_code_2,
                        onTap: () => Navigator.pushNamed(context, '/generate'),
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
                ],
              ),
            ),
          ),

          // 2. FITUR HISTORY SLIDE UP (Buka-Tutup)
          DraggableScrollableSheet(
            initialChildSize: 0.12,
            minChildSize: 0.12,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Recent History',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF43A078),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ValueListenableBuilder<List<TicketModel>>(
                        valueListenable: HomeController
                            .historyNotifier, // Mengacu ke static notifier
                        builder: (context, tickets, _) {
                          if (tickets.isEmpty) {
                            return const Center(
                              child: Text(
                                "No history yet",
                                style: TextStyle(fontFamily: 'Outfit'),
                              ),
                            );
                          }
                          return ListView.separated(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            itemCount: tickets.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return HistoryCard(ticket: tickets[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
