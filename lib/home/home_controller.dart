import 'package:flutter/material.dart';
import 'package:qr_scanner/qr_code/qr_code_view.dart';
import 'package:qr_scanner/features/history/models/ticket_model.dart';

class HomeController {
  static final ValueNotifier<List<TicketModel>> historyNotifier =
      ValueNotifier<List<TicketModel>>([]);

  void addTicketToHistory(
    String name,
    String studentClass, {
    bool status = false,
  }) {
    final newTicket = TicketModel(
      id: DateTime.now().toString(),
      name: name,
      classRoom: studentClass,
      isRedeemed: status,
    );
    historyNotifier.value = [newTicket, ...historyNotifier.value];
  }

  void processGalleryRedeem(String code) {
    if (code.isNotEmpty) {
      markAsRedeemed(code);
    }
  }

  void markAsRedeemed(String ticketId) {
    final List<TicketModel> currentHistory = List<TicketModel>.from(
      historyNotifier.value,
    );
    int index = currentHistory.indexWhere((t) => t.id == ticketId);

    if (index != -1) {
      currentHistory[index].isRedeemed = true;
      currentHistory[index].scannedAt = DateTime.now();
      historyNotifier.value = currentHistory;
    }
  }

  void goToQRCodeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrCodeView()),
    );
  }
}
