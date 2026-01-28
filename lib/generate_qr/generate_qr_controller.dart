import 'package:flutter/material.dart';

class GenerateQrController {
  final TextEditingController textController = TextEditingController();
  
  String qrData = "";

  void generateCode(Function setStateCallback) {
    if (textController.text.isNotEmpty) {
      qrData = textController.text;
      setStateCallback();
    }
  }
}