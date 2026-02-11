import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:qr_scanner/home/home_controller.dart';
import 'package:qr_scanner/qr_code/qr_code_service.dart';

class QrCodeController {
  final ImagePicker _picker = ImagePicker();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  final QrCodeService _service = QrCodeService();

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
            await processRedeem(qrData);
          }
        }
      }
    } catch (e) {
      log('Error galeri: $e');
    }
  }

  void scanQRCode(dynamic capture) {
    final List<dynamic> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        processRedeem(barcode.rawValue!);
        break;
      }
    }
  }

  Future<void> processRedeem(String ticketId) async {
    try {
      await _service.redeemTicket(ticketId);

      HomeController.instance.markAsRedeemed(ticketId);

      log('Berhasil Redeem: $ticketId');
    } catch (e) {
      log('Gagal Redeem ke Server: $e');
    }
  }
}
