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
import 'package:mobile_scanner/mobile_scanner.dart' as ms;
import 'package:qr_scanner/qr_code/qr_code_service.dart';

class QrCodeController {
  final QrCodeService service = QrCodeService();
  final ImagePicker _picker = ImagePicker();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();

  void scanQRCode(ms.BarcodeCapture barcodes) {
    final barcode = barcodes.barcodes.first.rawValue;
    log('Barcode found from camera: $barcode');
    redeemQRCode(barcode);
  }

  Future<void> scanFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final inputImage = InputImage.fromFilePath(image.path);

        final List<Barcode> barcodes = await _barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          final String? qrData = barcodes.first.rawValue;
          log('Barcode found from gallery: $qrData');
          redeemQRCode(qrData);
        } else {
          log('No QR Code found in this image.');
        }
      }
    } catch (e) {
      log('Error scanning from gallery: $e');
    }
  }

  void redeemQRCode(String? qrData) {
    log('Redeeming QR Code: $qrData');
    if (qrData != null) {
      service.scanTicket(qrData);
    }
  }

  void dispose() {
    _barcodeScanner.close();
  }
}