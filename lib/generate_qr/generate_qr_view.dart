import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_scanner/home/home_controller.dart';
import 'dart:typed_data';

class GenerateQrView extends StatefulWidget {
  const GenerateQrView({super.key});

  @override
  State<GenerateQrView> createState() => _GenerateQrViewState();
}

class _GenerateQrViewState extends State<GenerateQrView> {
  final ScreenshotController screenshotController = ScreenshotController();
  final HomeController _homeController = HomeController();
  final TextEditingController textController = TextEditingController();

  String qrData = "";

  Future<void> _saveQrCode() async {
    await screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        await Gal.putImageBytes(image);

        if (textController.text.isNotEmpty) {
          _homeController.addTicketToHistory(
            textController.text,
            "XI PPLG",
            status: false,
          );
        }

        if (!mounted) return;

        _showSuccessDialog(context);
      }
    });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF43A078), size: 60),
              SizedBox(height: 10),
              Text(
                "Download Berhasil",
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            "QR Code telah disimpan ke galeri ponsel Anda dan ditambahkan ke riwayat.",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Outfit'),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A078),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Oke",
                  style: TextStyle(color: Colors.white, fontFamily: 'Outfit'),
                ),
              ),
            ),
          ],
        );
      },
    );
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
            // ElevatedButton(
            //   onPressed: () {
            //     if (textController.text.isNotEmpty) {
            //       _homeController.addTicketToHistory(
            //         textController.text,
            //         "XI PPLG",
            //         status: false,
            //       );

            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text(
            //             "Tiket tersimpan di History (Belum di-scan)",
            //           ),
            //         ),
            //       );

            //       setState(() {});
            //     }
            //   },
            //   child: const Text("Generate & Simpan ke History"),
            // ),
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
