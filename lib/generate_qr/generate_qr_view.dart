import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_scanner/home/home_controller.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

class GenerateQrView extends StatefulWidget {
  const GenerateQrView({super.key});

  @override
  State<GenerateQrView> createState() => _GenerateQrViewState();
}

class _GenerateQrViewState extends State<GenerateQrView> {
  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController textController = TextEditingController();
  String qrData = "";
  final HomeController _homeController = HomeController();

  Future<void> _saveQrCode() async {
    await screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("QR Code disimpan ke Galeri!")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(title: const Text('Generate QR')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: "Masukkan data tiket",
              ),
              onChanged: (val) => setState(() => qrData = val),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  _homeController.addTicketToHistory(
                    textController.text,
                    "XI PPLG",
                    status: false, // Tambahkan parameter ini
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Tiket tersimpan di History (Belum di-scan)",
                      ),
                    ),
                  );

                  setState(() {});
                }
              },
              child: const Text("Generate & Simpan ke History"),
            ),
            const SizedBox(height: 30),

            if (qrData.isNotEmpty) ...[
              Screenshot(
                controller: screenshotController,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: QrImageView(
                    data: qrData,
                    size: 200,
                    foregroundColor: const Color(0xFF43A078),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveQrCode,
                icon: const Icon(Icons.download),
                label: const Text("Download QR Code"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A078),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
