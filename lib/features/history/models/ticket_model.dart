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
    this.isRedeemed = false,
    this.scannedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String,
      name: json['name'] as String,
      classRoom:
          json['classRoom'] as String,
      isRedeemed: json['isRedeemed'] as bool,
    );
  }
}
