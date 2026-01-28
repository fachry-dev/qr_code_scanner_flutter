import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/generate_qr/generate_qr_controller.dart';

class GenerateQrView extends StatefulWidget {
  const GenerateQrView({super.key});

  @override
  State<GenerateQrView> createState() => _GenerateQrViewState();
}

class _GenerateQrViewState extends State<GenerateQrView> {
  final GenerateQrController controller = GenerateQrController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), 
      appBar: AppBar(
        title: const Text('Generate QR Code', style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: "Enter text or ticket ID",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => controller.generateCode(() => setState(() {})),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A078),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Generate Now", 
                  style: TextStyle(fontFamily: 'Outfit', color: Colors.white, fontSize: 18)),
              ),
            ),
            
            const SizedBox(height: 40),

            if (controller.qrData.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                  ],
                ),
                child: Column(
                  children: [
                    QrImageView(
                      data: controller.qrData,
                      version: QrVersions.auto,
                      size: 250.0,
                      gapless: false,
                      foregroundColor: const Color(0xFF43A078), // QR berwarna hijau
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Data: ${controller.qrData}",
                      style: const TextStyle(fontFamily: 'Outfit', color: Colors.grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}