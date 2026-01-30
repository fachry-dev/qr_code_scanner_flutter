import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:qr_scanner/qr_code/qr_code_service.dart';

class QrCodeController {
  final QrCodeService service = QrCodeService();
  final ImagePicker _picker = ImagePicker();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();

  Future<void> scanFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final inputImage = InputImage.fromFilePath(image.path);

        final List<Barcode> barcodes = await _barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          final String? qrData = barcodes.first.rawValue;
          log('QR Berhasil dibaca dari galeri: $qrData');
          
          if (qrData != null) {

            service.scanTicket(qrData);
          }
        } else {
          log('Tidak ada QR Code yang ditemukan pada foto ini.');
        }
      }
    } catch (e) {
      log('Gagal mengambil foto dari galeri: $e');
    }
  }

  void dispose() {
    _barcodeScanner.close();
  }
}