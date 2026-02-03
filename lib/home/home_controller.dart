import 'package:flutter/material.dart';
import 'package:qr_scanner/qr_code/qr_code_view.dart';
import 'package:qr_scanner/features/history/models/ticket_model.dart'; //

class HomeController {
  static final ValueNotifier<List<TicketModel>> historyNotifier =
      ValueNotifier<List<TicketModel>>([]);
  // final HomeController homeController = HomeController();
  void addTicketToHistory(
    String name,
    String studentClass, {
    bool status = false,
  }) {
    final newTicket = TicketModel(
      id: DateTime.now().toString(),
      name: name,
      studentClass: studentClass,
      isRedeemed: status,
    );
    historyNotifier.value = [newTicket, ...historyNotifier.value];  }

  void markAsRedeemed(String name) {
    List<TicketModel> currentHistory = List.from(historyNotifier.value);

    for (int i = 0; i < currentHistory.length; i++) {
      if (currentHistory[i].name == name) {
        currentHistory[i] = TicketModel(
          id: currentHistory[i].id,
          name: currentHistory[i].name,
          studentClass: currentHistory[i].studentClass,
          isRedeemed: true,
        );
      }
    }
    historyNotifier.value = currentHistory;
  }

  void goToQRCodeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrCodeView()),
    );
  }
}
