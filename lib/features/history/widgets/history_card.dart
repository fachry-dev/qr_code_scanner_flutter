import 'package:flutter/material.dart';
import '../models/ticket_model.dart';
import 'package:qr_scanner/home/home_controller.dart';

class HistoryCard extends StatelessWidget {
  final dynamic ticket;
  final VoidCallback onTap;

  const HistoryCard({super.key, required this.ticket, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isRedeemed = ticket.isRedeemed;
    final Color statusColor = isRedeemed
        ? const Color(0xFF43A078)
        : Colors.redAccent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: statusColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: statusColor.withOpacity(0.1),
              child: Icon(
                isRedeemed ? Icons.check_circle : Icons.qr_code,
                color: statusColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ticket.classRoom,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Outfit',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                isRedeemed ? "REDEEMED" : "UNREDEEMED",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
