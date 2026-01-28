import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

class HistoryController {
  final ValueNotifier<List<TicketModel>> historyNotifier = ValueNotifier<List<TicketModel>>([
    TicketModel(id: '1', name: 'FACHRY WARDANA', studentClass: 'XI PPLG', isRedeemed: false),
    TicketModel(id: '2', name: 'RIZQI NOVILLA', studentClass: 'XI TRKJ', isRedeemed: true),
  ]);

  void addTicket(String name, String studentClass, bool status) {
    final newTicket = TicketModel(
      id: DateTime.now().toString(),
      name: name,
      studentClass: studentClass,
      isRedeemed: status,
    );
    historyNotifier.value = [newTicket, ...historyNotifier.value];
  }
}