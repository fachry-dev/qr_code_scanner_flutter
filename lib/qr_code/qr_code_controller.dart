// import 'dart:developer';

// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:qr_scanner/qr_code/qr_code_service.dart';

// class QrCodeController {
//    final QrCodeService service = QrCodeService();

//   void scanQRCode(BarcodeCapture barcodes){
//     final barcode = barcodes.barcodes.first.rawValue;
//     log('Barcode found: $barcode');
//     redeemQRCode(barcode);
//   }

//   void redeemQRCode(String? qrData) {
//     log('Redeeming QR Code: $qrData');
//     if(qrData != null) service.scanTicket(qrData);
//   }
// }

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
            _homeController.addTicketToHistory(qrData, "XI PPLG", status: true);
            log('Berhasil redeem dari galeri: $qrData');
          }
        }
      }
    } catch (e) {
      log('Error scan galeri: $e');
    }
  }

  void scanQRCode(dynamic capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        final String codeData = barcode.rawValue!;
        _homeController.markAsRedeemed(codeData);
        log('Barcode detected & Redeemed: $codeData');
        break;
      }
    }
  }
}
