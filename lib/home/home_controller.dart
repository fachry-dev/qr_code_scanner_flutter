import 'package:flutter/material.dart';
import 'package:qr_scanner/qr_code/qr_code_view.dart';

class HomeController {
  void goToQRCodeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrCodeView()),
    );
  }
}