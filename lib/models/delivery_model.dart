class DeliveryModel {
  final int id;
  final String recipient;
  final String date;
  final DeliveryStatus status;

  DeliveryModel({
    required this.id,
    required this.recipient,
    required this.date,
    required this.status,
  });
}

enum DeliveryStatus { requested, completed }
