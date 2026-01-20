import 'dart:developer';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/qr_code/qr_code_service.dart';

class QrCodeController {
   final QrCodeService service = QrCodeService(); 
   
  void scanQRCode(BarcodeCapture barcodes){
    final barcode = barcodes.barcodes.first.rawValue;
    log('Barcode found: $barcode');
    redeemQRCode(barcode);
  }

  void redeemQRCode(String? qrData) {
    log('Redeeming QR Code: $qrData');
    if(qrData != null) service.scanTicket(qrData);
  }
}