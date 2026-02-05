import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

class HistoryController {
  final ValueNotifier<List<TicketModel>> historyNotifier = ValueNotifier<List<TicketModel>>([
    TicketModel(id: '1', name: 'FACHRY WARDANA', classRoom: 'XI PPLG', isRedeemed: false),
    TicketModel(id: '2', name: 'RIZQI NOVILLA', classRoom: 'XI TRKJ', isRedeemed: true),
  ]);

  void addTicket(String name, String classRoom, bool status) {
    final newTicket = TicketModel(
      id: DateTime.now().toString(),
      name: name,
      classRoom: classRoom,
      isRedeemed: status,
    );
    historyNotifier.value = [newTicket, ...historyNotifier.value];
  }
}