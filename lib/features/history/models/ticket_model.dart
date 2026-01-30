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

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String,
      name: json['name'] as String,
      studentClass: json['student_class'] as String,
      isRedeemed: json['is_redeemed'] as bool,
    );
  }
}