class TicketModel {
  final String id;
  final String name;
  final String studentClass;
  final bool isRedeemed;

  TicketModel({
    required this.id,
    required this.name,
    required this.studentClass,
    required this.isRedeemed,
  });
}