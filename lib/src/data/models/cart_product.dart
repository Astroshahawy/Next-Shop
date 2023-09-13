import 'dart:convert';

class CartProduct {
  late int id;
  late String title;
  late double price;
  late String image;
  late int quantity;
  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = double.parse(json['price'].toString());
    image = json['image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'image': image,
        'quantity': quantity,
      };
}

String cartProductToJson(List<CartProduct> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

List<CartProduct> cartProductFromJson(String str) => List<CartProduct>.from(
      json.decode(str).map(
            (x) => CartProduct.fromJson(x),
          ),
    );
