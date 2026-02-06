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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                          onTap: () =>
                              Navigator.pushNamed(context, '/generate'),
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
                          onTap: () => controller.goToQRCodeView(context),
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
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),

          _buildHistorySheet(),

          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 1.0,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _buildHandleBar(),
                      const TabBar(
                        labelColor: Color(0xFF43A078),
                        indicatorColor: Color(0xFF43A078),
                        tabs: [
                          Tab(text: "Unredeemed"),
                          Tab(text: "Redeemed"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildHistoryList(
                              scrollController,
                              isRedeemed: false,
                            ),
                            _buildHistoryList(
                              scrollController,
                              isRedeemed: true,
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildHandleBar() {
    return Container(
      width: 60,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildHistoryList(
    ScrollController scrollController, {
    required bool isRedeemed,
  }) {
    return ValueListenableBuilder<List<TicketModel>>(
      valueListenable: HomeController.historyNotifier,
      builder: (context, allTickets, _) {
        final filteredTickets = allTickets
            .where((t) => t.isRedeemed == isRedeemed)
            .toList();

        if (filteredTickets.isEmpty) {
          return ListView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              SizedBox(height: 50),
              Center(child: Text("Belum ada tiket")),
            ],
          );
        }

        return ListView.separated(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: filteredTickets.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final ticket = filteredTickets[index];
            return HistoryCard(
              ticket: ticket,
              onTap: () => _showTicketDetail(context, ticket),
            );
          },
        );
      },
    );
  }

  void _showTicketDetail(BuildContext context, TicketModel ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Informasi Tiket",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text("Nama: ${ticket.name}"),
            Text("ID Tiket: ${ticket.id}"),
            if (ticket.isRedeemed && ticket.scannedAt != null)
              Text(
                "Waktu Scan: ${ticket.scannedAt.toString().substring(0, 16)} WIB",
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySheet() {
    return const SizedBox.shrink();
  }
}
