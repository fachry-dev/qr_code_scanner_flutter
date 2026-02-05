class TicketModel {
  final String id;
  final String name;
  final String classRoom;
  bool isRedeemed;
  DateTime? scannedAt;

  TicketModel({
    required this.id,
    required this.name,
    required this.classRoom,
    required this.isRedeemed,
    this.scannedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String,
      name: json['name'] as String,
      classRoom: json['class_room'] as String,
      isRedeemed: json['is_redeemed'] as bool,
    );
  }
}