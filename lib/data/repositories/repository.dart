import 'package:next_shop_app/data/api/api.dart';
import 'package:next_shop_app/data/models/orders.dart';
import 'package:next_shop_app/data/models/product.dart';
import 'package:next_shop_app/data/models/user.dart';

class ApiRepository {
  late ApiServices apiServices;

  ApiRepository(this.apiServices);

  Future<String> signin(
      {required String userName, required String password}) async {
    final response =
        await apiServices.auth(userName: userName, password: password);
    final token = response['token'];
    return token;
  }

  Future<List<Product>> getProducts() async {
    final products = await apiServices.getAllProducts();
    return products.map((product) => Product.fromJson(product)).toList();
  }

  Future<List> getAllCategories() async {
    final categories = await apiServices.getAllCategories();
    return categories;
  }

  Future<List<Product>> getSingleCategory(String category) async {
    final products = await apiServices.getSingleCategory(category);
    return products.map((product) => Product.fromJson(product)).toList();
  }

  Future<List<Order>> getOrders() async {
    final orders = await apiServices.getOrders();
    return orders.map((order) => Order.fromJson(order)).toList();
  }

  Future<User> getUserProfile() async {
    final user = await apiServices.getUser();
    return User.fromJson(user);
  }
}
