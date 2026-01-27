import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart' show MobileScanner;

import 'package:qr_scanner/qr_code/qr_code_controller.dart';



class QrCodeView extends StatelessWidget {

  final QrCodeController controller = QrCodeController();



  QrCodeView({super.key});



  @override

  Widget build(BuildContext context) {

    return MobileScanner(

      onDetect: controller.scanQRCode,

    );
  }
}