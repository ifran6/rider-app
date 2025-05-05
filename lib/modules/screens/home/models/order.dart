class Order {
  final String id;
  final String restaurant;
  final String location;
  final String customer;
  final String address;
  final String items;
  final String estimatedTime;
  final String distance;
  final String payment;
  final String status;

  Order({
    required this.id,
    required this.restaurant,
    required this.location,
    required this.customer,
    required this.address,
    required this.items,
    required this.estimatedTime,
    required this.distance,
    required this.payment,
    required this.status,
  });
}