import 'package:intl/intl.dart';

class Order {
  late int id;
  late int userId;
  late String date;
  late List<OrderProducts> orderProducts;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = DateFormat('EEE, dd/MM/yyyy').format(
      DateTime.parse(json['date']),
    );
    orderProducts = List<OrderProducts>.from(
      json['products'].map(
        (e) => OrderProducts.fromJson(e),
      ),
    );
  }
}

class OrderProducts {
  late int productId;
  late int quantity;

  OrderProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }
}
