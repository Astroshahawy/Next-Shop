class User {
  late int id;
  late Address address;
  late String email;
  late String username;
  late String password;
  late Name name;
  late String phone;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = Address.fromJson(json['address']);
    email = json['email'];
    username = json['username'];
    password = json['password'];
    name = Name.fromJson(json['name']);
    phone = json['phone'];
  }
}

class Name {
  late String firstname;
  late String lastname;

  Name.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }
}

class Address {
  late String city;
  late String street;
  late int number;
  late String zipcode;

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    street = json['street'];
    number = json['number'];
    zipcode = json['zipcode'];
  }
}

class UserLoginData {
  late String username;
  late String password;

  UserLoginData({
    required this.username,
    required this.password,
  });

  UserLoginData.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    password = map['password'];
  }
}
