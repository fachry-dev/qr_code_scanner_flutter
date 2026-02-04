import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/qr_code/qr_code_controller.dart';
import 'package:qr_scanner/home/home_controller.dart';
import 'package:gal/gal.dart';
import 'package:qr_scanner/features/history/widgets/history_card.dart';

class QrCodeView extends StatelessWidget {
  final QrCodeController controller = QrCodeController();

  QrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Qr Code',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MobileScanner(onDetect: (capture) => controller.scanQRCode(capture)),

          // Layer Overlay
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 260,
                    width: 260,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- TOMBOL GALERI KECIL (SUDAH ADA) ---
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.image_outlined, color: Color(0xFF43A078)),
                onPressed: () => controller.scanFromGallery(),
              ),
            ),
          ),

          // Layer UI
          Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  'Scan the qr for redeem ticket',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              
              // Horizontal History Cards (Opsional, tetap ada agar user bisa melihat status)
              Container(
                height: 110,
                padding: const EdgeInsets.only(bottom: 10),
                child: ValueListenableBuilder(
                  valueListenable: HomeController.historyNotifier,
                  builder: (context, tickets, _) {
                    if (tickets.isEmpty) return const SizedBox();
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 280,
                          margin: const EdgeInsets.only(right: 12),
                          child: HistoryCard(ticket: tickets[index]),
                        );
                      },
                    );
                  },
                ),
              ),

              // --- TOMBOL UTAMA DIPERBARUI: HANYA SCAN QR ---
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 50),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    // Tombol ini sekarang hanya untuk memicu fokus kamera/instruksi scan
                    onPressed: () {}, 
                    icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                    label: const Text(
                      'Scan QR Code',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF43A078),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}