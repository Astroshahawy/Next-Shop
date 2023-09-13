import 'package:next_shop_app/src/data/api/api.dart';
import 'package:next_shop_app/src/data/models/orders.dart';
import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/data/models/user.dart';

class ApiRepository {
  late ApiServices apiServices;

  ApiRepository(this.apiServices);

  Future<String> login(
      {required String userName, required String password}) async {
    final response =
        await apiServices.auth(userName: userName, password: password);
    final token = response['token'];
    return token;
  }

  Future<int> register(
      {required String userName,
      required String password,
      required String userEmail}) async {
    final response = await apiServices.register(
        userName: userName, userEmail: userEmail, password: password);
    final id = response['id'];
    return id;
  }

  Future<List<Product>> getProducts() async {
    final products = await apiServices.getAllProducts();
    return products.map((product) => Product.fromJson(product)).toList();
  }

  Future<List<Product>> getLimitedProducts(int limit) async {
    final products = await apiServices.getLimitedProducts(limit);
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

  Future<void> addProduct({
    required String title,
    required double price,
    required String description,
    required String image,
    required String category,
  }) async {
    await apiServices.addProduct(
        title: title,
        price: price,
        description: description,
        image: image,
        category: category);
  }

  Future<void> editProduct({
    required int id,
    required String title,
    required double price,
    required String description,
    required String image,
    required String category,
  }) async {
    await apiServices.editProduct(
        id: id,
        title: title,
        price: price,
        description: description,
        image: image,
        category: category);
  }

  Future<Product> deleteProduct({required int id}) async {
    final product = await apiServices.deleteProduct(id: id);
    return Product.fromJson(product);
  }
}
