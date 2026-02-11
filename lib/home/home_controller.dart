import 'package:flutter/material.dart';
import 'package:qr_scanner/qr_code/qr_code_view.dart';
import 'package:qr_scanner/features/history/models/ticket_model.dart';

class HomeController {
  static final HomeController instance = HomeController();

  static final ValueNotifier<List<TicketModel>> historyNotifier =
      ValueNotifier<List<TicketModel>>([]);

  void addTicketToHistory(
    String name,
    String studentClass, {
    required String id,
    bool status = false,
  }) {
    final newTicket = TicketModel(
      id: id,
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
      final updatedList = List<TicketModel>.from(historyNotifier.value);
      updatedList[index] = updatedList[index].copyWith(
        isRedeemed: true,
        scannedAt: DateTime.now(),
      );

      historyNotifier.value = updatedList;
    } else {
      debugPrint("ID Tiket tidak ditemukan di riwayat: $ticketId");
    }
  }

  void goToQRCodeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrCodeView()),
    );
  }
}
