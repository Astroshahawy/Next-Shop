import 'dart:convert';

import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/core/network/dio_helper.dart';

class ApiServices {
  final BaseDioHelper baseDioHelper;

  ApiServices(this.baseDioHelper);

  Future getData({required String url}) async {
    return await baseDioHelper.get(endPoint: url);
  }

  Future<Map<String, dynamic>> auth(
      {required String userName, required String password}) async {
    return await baseDioHelper.post(
        endPoint: AppApis.authEP,
        data: json.encode({'username': userName, 'password': password}));
  }

  Future<Map<String, dynamic>> register({
    required String userName,
    required String userEmail,
    required String password,
  }) async {
    return await baseDioHelper.post(
        endPoint: AppApis.registerEP,
        data: json.encode({
          'username': userName,
          'email': userEmail,
          'password': password,
        }));
  }

  Future<List> getAllProducts() async {
    return await getData(url: AppApis.productsEP);
  }

  Future<List> getLimitedProducts(int limit) async {
    return await getData(
        url: AppApis.productsEP + AppApis.limitEP + limit.toString());
  }

  Future<List> getAllCategories() async {
    return await getData(url: AppApis.allCategoriesEP);
  }

  Future<List> getSingleCategory(String category) async {
    return await getData(url: AppApis.categoryEP + category);
  }

  Future<List> getOrders() async {
    return await getData(url: AppApis.ordersEP);
  }

  Future getUser() async {
    return await getData(url: AppApis.userEP);
  }

  Future<Map<String, dynamic>> addProduct({
    required String title,
    required double price,
    required String description,
    required String image,
    required String category,
  }) async {
    return await baseDioHelper.post(
        endPoint: AppApis.productsEP,
        data: json.encode({
          'title': title,
          'price': price,
          'description': description,
          'image': image,
          'category': category,
        }));
  }

  Future<Map<String, dynamic>> editProduct({
    required int id,
    required String title,
    required double price,
    required String description,
    required String image,
    required String category,
  }) async {
    return await baseDioHelper.patch(
        endPoint: '${AppApis.productsEP}/$id',
        data: json.encode({
          'title': title,
          'price': price,
          'description': description,
          'image': image,
          'category': category,
        }));
  }

  Future<Map<String, dynamic>> deleteProduct({
    required int id,
  }) async {
    return await baseDioHelper.delete(
      endPoint: '${AppApis.productsEP}/$id',
    );
  }
}
