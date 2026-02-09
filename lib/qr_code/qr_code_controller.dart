import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:qr_scanner/home/home_controller.dart';

class QrCodeController {
  final ImagePicker _picker = ImagePicker();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  final HomeController _homeController = HomeController();

  Future<void> scanFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final inputImage = InputImage.fromFilePath(image.path);
        final List<Barcode> barcodes = await _barcodeScanner.processImage(
          inputImage,
        );

        if (barcodes.isNotEmpty) {
          final String? qrData = barcodes.first.rawValue;
          if (qrData != null) {
            HomeController.instance.markAsRedeemed(qrData);
            log('Berhasil Scan dari Galeri: $qrData');
          }
        }
      }
    } catch (e) {
      log('Error saat membuka galeri: $e');
    }
  }

  void scanQRCode(dynamic capture) {
    final List<dynamic> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        _homeController.markAsRedeemed(barcode.rawValue!);
        break;
      }
    }
  }
}
