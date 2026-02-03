import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

class HistoryCard extends StatelessWidget {
  final TicketModel ticket;

  const HistoryCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = ticket.isRedeemed ? const Color(0xFF43A078) : Colors.red;
    final String statusText = ticket.isRedeemed ? 'REDEEMED' : 'UNREDEEMED';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: statusColor,
            child: const Icon(Icons.qr_code, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Nama Peserta
                Text(
                  ticket.name,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: statusColor,
                  ),
                ),
                Text(
                  ticket.studentClass,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: statusColor),
        ],
      ),
    );
  }
}